require 'spec_helper'

describe User do
  context "#find_or_create_by_token" do
    let(:email) {'foo@nulogy.com'}
    let(:token) do
      {
        'user_info' => {
          'email' => email
        }
      }
    end

    it "can find" do
      user = User.make! email: email
      result = User.find_or_create_by_token(token)

      result.should == user
    end

    it "can create" do
      user = User.make! email: email
      User.find_or_create_by_token(token)
      User.all.count.should == 1
    end
  end

  context "#orderers" do
    it "lists users who have ordered" do
      users = User.make! 2
      users.each {|u| u.order("Beef Burger" => 5)}

      orderers = User.orderers

      orderers.length.should == 2
      users.each do |user|
        orderers.include?(user).should be_true
      end
    end

    it "does not include users who have not ordered" do
      not_included = nil
      Timecop.travel 2.weeks.ago do
        not_included = User.make!.order('Beef Burger' => 10)
      end

      included = User.make!
      included.order("Beef Burger" => 10)

      orderers = User.orderers

      orderers.include?(included).should be_true
      orderers.include?(not_included).should be_false
    end
  end

  context "#non_orderers" do
    it "lists users who have not ordered" do
      users = User.make! 2

      non_orderers = User.non_orderers

      non_orderers.length.should == 2
      users.each do |user|
        non_orderers.include?(user).should be_true
      end
    end

    it "does not include users who have ordered" do
      included = nil
      Timecop.travel 1.weeks.ago do
        included = User.make!
        included.order('Beef Burger' => 10)
      end

      excluded = User.make!
      excluded.order("Beef Burger" => 10)

      non_orderers = User.non_orderers

      non_orderers.include?(excluded).should be_false
      non_orderers.include?(included).should be_true
    end
  end
end

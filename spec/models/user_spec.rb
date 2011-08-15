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

  context "#non_orderers"

  context "creating an order" do
    before(:each) do
      @user = User.make!
    end

    it "sets food" do
      order = @user.order("Beef Burger" => 5)
      order["Beef Burger"].should == 5
    end

    it "sets user" do
      order = @user.order("Beef Burger" => 5)
      order.user.should == @user
    end

    it "can't happen more then once a week" do
      @user.order("Beef Burger" => 5)
      order = @user.order("Beef Burger" => 5)

      order.errors.empty?.should be_false
      @user.orders.count.should == 1
    end

    it "can happen again next week" do
      @user.order("Beef Burger" => 5)
      Timecop.travel 1.week.from_now do
        @user.order("Beef Burger" => 5)
      end

      @user.orders.count.should == 2
    end
  end
end

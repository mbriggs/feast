require 'spec_helper'

describe User do
  context "#find_or_create_by_token" do
    let(:token) do
      {
        'user_info' => {
          'email' => 'foo@nulogy.com'
        }
      }
    end

    it "can find" do
      user = User.create \
        :email => 'foo@nulogy.com',
        :password => 'password'
      result = User.find_or_create_by_token(token)

      result.should == user
    end

    it "can create" do
      user = User.create \
        :email => 'foo@nulogy.com',
        :password => 'password'
      User.find_or_create_by_token(token)
      User.all.count.should == 1
    end
  end

  context "creating an order" do
    before(:each) do
      @user = User.create \
        :email => 'foo@nulogy.com',
        :password => 'password'
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

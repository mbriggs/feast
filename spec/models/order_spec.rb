require 'spec_helper'

describe Order do
  it "can display a description" do
    order = Order.new("Beef Burger" => 2, "Veggie Burger" => 3, "Coke" => 1)
    order.description.should == "2 Beef Burgers, 3 Veggie Burgers, 1 Coke"
  end

  it "won't die if you try to send a message for a field that doesn't exist yet" do
    Order.new.send("Beef Burger").should == ""
  end

  context "creating (from the user)" do
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

require 'spec_helper'

describe Order do
  it "can display a description" do
    Order.new("Beef Burger" => 2).description.should == "2 Beef Burgers"
  end
end

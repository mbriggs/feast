require 'spec_helper'

describe OrdersController do
  let(:user) { sign_in User.make! }

  describe "GET index" do
    it "assigns @order" do
      get :index

      assigns(:order).should == Order.new
    end

    it "assigns @orders" do
      order = user.order("Foo" => 5)
      get :index

      assigns(:orders).should == [order]
    end
  end
end

class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @order = Order.new
    @orders = current_user.orders
  end
end

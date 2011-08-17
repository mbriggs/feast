class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @order = Order.new
    @orders = current_user.orders
  end

  def create
    food = params.dup
    food.delete('other-food') unless food.delete('choose-other-food')
    food.delete('other-alcohol') unless food.delete('choose-other-alcohol')

    @order = current_user.order(food)
    @orders = current_user.orders

    render 'index'
  end
end

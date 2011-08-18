class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @order = Order.new
    @orders = current_user.orders
  end

  def create
    food = params[:food].dup
    food.delete('other-food') unless params['choose-other-food']
    food.delete('other-alcohol') unless params['choose-other-alcohol']

    @order = current_user.order(food)
    @orders = current_user.orders

    render 'index'
  end
end

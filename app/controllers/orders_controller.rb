class OrdersController < ApplicationController
  before_filter :authenticate_user!, :load_orders

  def index
    @order = Order.new
  end

  def create
    food = params[:order].dup
    food.values.map(&:to_i)

    prune! food, 'Other Food'
    prune! food, 'Other Alcohol'

    @order = current_user.order(food)

    render 'index'
  end

private
  def load_orders
    @previous_orders = current_user.orders
  end

  def prune!(food, name)
    enabler_id = "choose-#{name.parameterize}"

    food.delete(name) unless food[enabler_id]
    food.delete(enabler_id)

    food.each do |item, quantity|
      food.delete(item) if quantity == 0
    end
  end
end

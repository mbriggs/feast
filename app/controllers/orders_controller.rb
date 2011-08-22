class OrdersController < ApplicationController
  before_filter :authenticate_user!, :load_orders

  def index
    load_order
  end

  def create
    food = params[:order].dup
    prune! food, 'Other Food'
    prune! food, 'Other Alcohol'

    food.each do |item, quantity|
      food[item] = quantity.to_i
    end

    @order = current_user.order(food)

    render 'index'
  end

private

  def load_orders
    @previous_orders = current_user.previous_orders
  end

  def load_order
    @order = current_user.already_ordered?  ? current_user.current_order : Order.new
  end

  def prune!(food, name)
    enabler_id = "choose-#{name.parameterize}"

    food.delete(name) unless food[enabler_id]
    food.delete(enabler_id)
  end
end

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise \
    :omniauthable,
    :database_authenticatable,
    :registerable,
    :validatable

  embeds_many :orders

  class << self
    def find_or_create_by_token(token)
      email = token['user_info']['email']
      where(:email => email).first or create(:email => email, :password => 'foobar')
    end

    def orderers
      all(conditions: { "orders.created_at" => { "$gte" => last_friday.to_time }})
    end

    def non_orderers
      all(conditions: { "orders.created_at" => { "$not" => { "$gte" => last_friday.to_time }}})
    end
  end

  def order(food)
    if already_ordered?
      Order.errored("You cannot place another order this week")
    else
      orders.create! food
    end
  end

  def already_ordered?
    not current_order.nil?
  end

  def current_order
    orders.where(:created_at.gt => last_friday).first
  end
end

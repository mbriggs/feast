class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise \
    :omniauthable,
    :database_authenticatable,
    :registerable,
    :validatable

  embeds_many :orders

  def self.find_or_create_by_token(token)
    email = token['user_info']['email']
    where(:email => email).first or create(:email => email, :password => 'foobar')
  end

  def self.orderers
    all(conditions: { "orders.created_at" => { "$gte" => last_friday.to_time }})
  end

  def order(food)
    if already_ordered?
      Order.errored("You cannot place another order this week")
    else
      orders.create! food
    end
  end

  def already_ordered?
    not orders
      .where(:created_at.gt => last_friday)
      .first
      .nil?
  end

end

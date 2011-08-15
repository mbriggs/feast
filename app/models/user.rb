class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise \
    :omniauthable,
    :database_authenticatable,
    :registerable,
    :validatable

  has_many :orders

  def self.find_or_create_by_token(token)
    email = token['user_info']['email']
    where(:email => email).first or create(:email => email, :password => 'foobar')
  end

  def order(food)
    if already_ordered?
      # Order.errored("")
    else
      orders.create! food
    end
  end

  private

  def already_ordered?
    pp orders
      .where(:created_at.gt => Chronic.parse('last friday').to_date)
      .first
    not orders
      .where(:created_at.gt => Chronic.parse('last friday').to_date)
      .first
      .nil?
  end
end

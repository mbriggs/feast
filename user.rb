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
    where(email: email).first or create(email: email, password: 'foobar')
  end
end

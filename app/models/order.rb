class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :user

  def self.errored(msg)
    new.tap {|o| o.errors.add(:base, msg)}
  end
end

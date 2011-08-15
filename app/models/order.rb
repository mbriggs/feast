class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  def self.errored(msg)
    new.tap {|o| o.errors.add(:base, msg)}
  end
end

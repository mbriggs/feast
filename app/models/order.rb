class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  field :food, :type => Hash

  def self.errored(msg)
    new.tap {|o| o.errors.add(:base, msg)}
  end
end

class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  def self.errored(msg)
    new.tap {|o| o.errors.add(:base, msg)}
  end

  def method_missing(message, *args)
    write_attribute(message, "") unless attribute_present?(message)
    super(message, *args)
  end

  def description
    #copy/paste from rails
    pluralize = lambda do |count, singular, plural = nil|
      "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
    end

    attributes.keys
      .reject {|field| ["_id", "updated_at", "created_at"].include? field }
      .reject {|field| read_attribute(field) == 0 }
      .each_with_object([]) {|field, desc|
        desc << pluralize.call(attributes[field], field)
      }
      .join(', ')
  end

end

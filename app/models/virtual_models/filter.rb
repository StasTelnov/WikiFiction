class Filter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    raise NotImplementedError, "#{self.class} is an abstract class and cannot be instantiated." if instance_of?(Filter)

    return if attributes.blank?

    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def filtering_params
    params = {}
    filtering_keys.each do |key|
      value = public_send(key)
      params[key] = value if value.present?
    end
    params
  end

  def filtering_keys
    raise NotImplementedError, "You must implement #{__method__} method in #{self.class} class."
  end

end
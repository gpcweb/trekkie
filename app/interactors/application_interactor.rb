class ApplicationInteractor
  attr_accessor :errors

  def self.call(...)
    new(...).execute
  end

  def initialize(*_args, **_kwargs, &_block)
    @errors = {}
  end

  def success?
    errors.empty?
  end

  def error?
    !success?
  end

  private

  def add_errors(instance)
    instance.errors.each do |err|
      add_attribute_error(err.attribute, { message: err.message, details: nil })
    end

    false
  end

  def error(key = :base, message:, details: nil)
    raise ArgumentError, 'message cannot be nil' if message.nil?

    add_attribute_error(key, { message: message, details: details })

    false
  end

  def add_attribute_error(key, value)
    key = :base if key.nil?
    key = key.to_sym if key.is_a?(String)

    if errors[key]
      errors[key] << value
    else
      errors[key] = [value]
    end
  end
end

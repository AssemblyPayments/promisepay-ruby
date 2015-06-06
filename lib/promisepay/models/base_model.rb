module Promisepay
  # Base model for all the other models to inherit from
  class BaseModel
    def initialize(client, attributes = {})
      @client = client
      @attributes = attributes
    end

    def method_missing(name, *args, &block)
      if @attributes.key?(name.to_s)
        @attributes[name.to_s]
      else
        super
      end
    end
  end
end

module Promisepay
  # Base model for all the other models to inherit from
  class BaseModel
    def initialize(client, attributes = {})
      @client = client
      @attributes = stringify_keys(attributes)
    end

    def method_missing(name, *args, &block)
      if @attributes.key?(name.to_s)
        @attributes[name.to_s]
      else
        super
      end
    end

    private

    def stringify_keys(hash)
      Hash[hash.map { |k, v| [k.to_s, v] }]
    end
  end
end

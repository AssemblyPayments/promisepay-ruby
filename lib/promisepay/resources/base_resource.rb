module Promisepay
  # Base resource for all the other resources to inherit from
  class BaseResource
    def initialize(client)
      @client = client
    end

    def method_missing(name, *args, &block)
      if instance_methods.include?(model) && respond_to?(name)
        model.new(@client, id: args[0]).send(name, *args[1..-1])
      else
        super
      end
    end

    def respond_to?(name, include_all = false)
      super || model.new(@client).respond_to?(name, include_all)
    end
  end
end

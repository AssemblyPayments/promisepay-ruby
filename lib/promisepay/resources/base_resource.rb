module Promisepay
  # Base resource for all the other resources to inherit from
  class BaseResource
    def initialize(client)
      @client = client
    end
  end
end

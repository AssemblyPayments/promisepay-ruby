module Promisepay
  # Resource for the Tools API
  class Tool
    def initialize(client)
      @client = client
    end

    # Displays a health check of the PromisePay service.
    #
    # @see https://reference.promisepay.com/#health-check
    #
    # @return [Hash]
    def health_check
      JSON.parse(@client.get('status').body)
    end
  end
end

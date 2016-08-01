
module Promisepay
  # Manage Charges
  class Charge < BaseModel
    # Get the buyer associated with the charge.
    #
    # @see https://reference.promisepay.com/#show-charge-buyer
    #
    # @return [Promisepay::User]
    def buyer
      response = JSON.parse(@client.get("charges/#{send(:id)}/buyers").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Get current status.
    #
    # @see https://reference.promisepay.com/#show-charge-status
    #
    # @return [Hash]
    def status
      response = JSON.parse(@client.get("charges/#{send(:id)}/status").body)
      response['charges']
    end
  end
end

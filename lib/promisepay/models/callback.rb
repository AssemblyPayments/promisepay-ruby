
module Promisepay
  # Manage Callback
  class Callback < BaseModel
    # Update the attributes of a callback.
    #
    # @see https://reference.promisepay.com/#update-callback
    #
    # @param attributes [Hash] Callback's attributes to be updated.
    #
    # @return [self]
    def update(attributes)
      response = JSON.parse(@client.patch("callbacks/#{send(:id)}", attributes).body)
      @attributes = response['callbacks']
      self
    end

    # Deletes a callback on a marketplace.
    #
    # @see https://reference.promisepay.com/#delete-callback
    #
    #
    # @return [Boolean]
    def delete
      response = JSON.parse(@client.delete("callbacks/#{id}").body)
      return (response['callbacks'] && response['callbacks'] == 'Successfully redacted')
    end

  end
end

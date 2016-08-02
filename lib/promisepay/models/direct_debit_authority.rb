module Promisepay
  # Manage Direct Debit Authorities
  class DirectDebitAuthority < BaseModel
    # Delete a specific Direct Debit Authority
    #
    # @see https://reference.promisepay.com/#delete-direct-debit-authority
    #
    # @return [Boolean]
    def delete
      @client.delete("direct_debit_authorities/#{id}")
      true
    end
  end
end

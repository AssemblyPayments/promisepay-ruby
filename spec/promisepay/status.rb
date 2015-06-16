module Promisepay
  # Manage Statuses for items and verifications(sellers)
  #
  #  @see http://docs.promisepay.com/v2.2/docs/statuses
  class Status < BaseModel
    attr_reader :name, :code, :description

    def initialize(options = {})
      @name = options['name'] || options['state']
      @code = options['code'] || options['satus_code']
      @description = options['description']
    end
  end
end

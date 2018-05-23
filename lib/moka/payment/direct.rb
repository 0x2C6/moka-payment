require 'moka/request'
require 'moka/configuration'
require 'moka/error'
require 'moka/payment/payment'

module Moka
  module Payment
    class Direct < Moka::Payment::Payment

      def initialize(details = {})
        super(details)
      end

      def self.payment_details
        @payment_details = Moka::Payment::Direct.new
        super @payment_details
      end

      def success?
        if @response["Data"]
          return true if @response["Data"]["IsSuccessful"]
        end
        return false
      end
    end
  end
end

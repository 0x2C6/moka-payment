require 'moka/request'
require 'moka/configuration'
require 'moka/error'
require 'moka/payment/payment'

module Moka
  module Payment
    class Direct3D < Moka::Payment::Payment

      class << self
        def paid_successfully?(params)
          unless params["isSuccessful"] == "False"
            return params
          end
          return false
        end
      end

      def initialize(details={})
        super details
      end

      def self.payment_details
        @payment_details = Moka::Payment::Direct3D.new
        super @payment_details
      end

      def success?
       return true if @response["ResultCode"] == "Success"
       return false
      end

      def varify_payment_url
        return @response["Data"] if @response["Data"]
        return false
      end

    end
  end
end

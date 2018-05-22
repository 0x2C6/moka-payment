require 'moka/request'
require 'moka/configuration'
require 'moka/error'
require 'moka/payment/payment'

module Moka
  module Payment
    class Direct3D < Moka::Payment::Payment

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

    end
  end
end

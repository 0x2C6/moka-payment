require 'moka/payment'
require 'moka/request'

module Moka
  module Payment
    class Capture < Moka::Payment::Payment
      attr_accessor :virtual_pos_order_id, :other_trx_code, :amount, :client_ip

      def initialize(details = {})
        super
        @virtual_pos_order_id = details[:virtual_pos_order_id]
        @other_trx_code = details[:other_trx_code]
        @amount = details[:amount]
        @client_ip = details[:client_ip]
      end

      def self.details
        @@capture_details = Moka::Payment::Capture.new
        super @@capture_details
      end

      def capture
        @response = Moka::Request.capture(@@capture_details)
        @error = Moka::Error::RequestError.new
        @error.message = @response["ResultCode"] unless @response["Data"]
        return @response
      end

      def request_details
        @@capture_details
      end

    end
  end
end

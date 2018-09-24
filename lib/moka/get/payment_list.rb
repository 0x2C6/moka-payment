require 'moka/request'
require 'moka/configuration'

module Moka
  module Get
    class PaymentList
      attr_accessor :dealer_code, :username, :password, :check_key, :payment_start_date,
                    :payment_end_date, :payment_status, :trx_status

      def initialize(details = {})
        @dealer_code = Moka.config.dealer_code
        @username = Moka.config.username
        @password = Moka.config.password
        @check_key = Moka.config.check_key
        @payment_start_date = details[:payment_start_date]
        @payment_end_date = details[:payment_end_date]
        @payment_status = details[:payment_status]
        @trx_status = details[:trx_status]
      end

      def self.details
        @@response = nil
        @@payment_list_details = Moka::Get::PaymentList.new
        yield @@payment_list_details if block_given?
        return @@payment_list_details
      end

      def request_details
        @@payment_list_details
      end

      def get_list
        @@response = Moka::Request.get_payment_list(@@payment_list_details)
      end

      def response
        @@response
      end


      def success?
        if @@response["Data"]
          return true if @@response["Data"]["IsSuccessful"]
        end if @@response
        return false
      end

      def list_count
        if @@response["Data"]
          return @@response["Data"]["ListItemCount"]
        end if @@response
        return 0
      end
    end
  end
end

require 'moka/request'
require 'moka/configuration'
require 'moka/error'

module Moka
  module Payment
    class Direct
      attr_accessor :dealer_code, :username, :password, :check_key,
                    :card_holder_full_name, :card_number, :exp_month,
                    :exp_year, :cvc_number, :amount, :currency, :installment_number,
                    :client_ip, :other_trx_code, :is_pre_auth, :is_pool_payment,
                    :integrator_id, :software, :description, :sub_merchant_name,
                    :buyer_full_name, :buyer_email, :buyer_gsm_number, :buyer_address

      def initialize(details = {})
        @dealer_code = Moka.config.dealer_code
        @username = Moka.config.username
        @password = Moka.config.password
        @check_key = Moka.config.check_key
        @card_holder_full_name = details[:card_number]
        @card_number = details[:card_number]
        @card_holder_full_name = details[:card_holder_full_name]
        @exp_month = details[:exp_month]
        @exp_year = details[:exp_year]
        @cvc_number = details[:cvc_number]
        @amount = details[:amount]
        @currency = details[:currency] || "USD"
        @installment_number = details[:installment_number] || 1
        @client_ip = details[:client_ip]
        @other_trx_code = details[:other_trx_code]
        @is_pre_auth = details[:is_pre_auth] || 0
        @is_pool_payment = details[:is_pool_payment]
        @integrator_id = details[:installment_number]
        @software = details[:software]
        @sub_merchant_name = details[:sub_merchant_name]
        @description = details[:description]
        @buyer_full_name = details[:buyer_full_name]
        @buyer_email = details[:buyer_email]
        @buyer_gsm_number = details[:buyer_gsm_number]
        @buyer_address = details[:buyer_address]
      end

      def pay
        return raise Moka::Error::NullPaymentInformation if [ # Bu parametlerden hec biri bos gelmemelidi xetasi
          @dealer_code, @username, @password, @check_key,
          @card_holder_full_name, @card_number, @exp_month, @exp_year,
          @cvc_number, @amount
        ].any? { |detail| detail.nil? }
        @response = Moka::Request.direct_payment(@@payment_details)
        @error = Moka::Error::RequestError.new
        @error.message = @response["ResultCode"] unless @response["Data"]
        return @response
      end

      def self.payment_details
        @@payment_details = Moka::Payment::Direct.new
        yield @@payment_details
        return @@payment_details
      end

      def errors
        @error
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

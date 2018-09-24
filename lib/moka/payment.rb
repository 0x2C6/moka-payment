require 'moka/request'
require 'moka/configuration'
require 'moka/error'

module Moka
  module Payment
    class Payment
      attr_accessor :dealer_code, :username, :password, :check_key,
                    :card_holder_full_name, :card_number, :exp_month, :exp_year,
                    :cvc_number, :card_token, :amount, :currency, :redirect_url, :redirect_type,
                    :client_ip, :other_trx_code, :is_pre_auth, :is_pool_payment,
                    :integrator_id, :software, :description, :sub_merchant_name, :installment_number,
                    :buyer_full_name, :buyer_email, :buyer_gsm_number, :buyer_address

      def initialize(details = {})
        @dealer_code = Moka.config.dealer_code
        @username = Moka.config.username
        @password = Moka.config.password
        @check_key = Moka.config.check_key
      end

      def pay
        raise Moka::Error::NotDirectOrDirect3DPayment unless @@payment_details.is_a?(Moka::Payment::Direct) ||
        @@payment_details.is_a?(Moka::Payment::Direct3D)
        raise Moka::Error::NullRedirectUrl if @@payment_details.is_a?(Moka::Payment::Direct3D) &&
        @@payment_details.redirect_url.nil?
        required_params = [
          @dealer_code, @username, @password, @check_key,
          @card_holder_full_name, @card_token, @amount
        ]

        unless @card_token
          required_params.delete(@card_token)
          required_params.push(@card_number, @exp_month, @exp_year, @cvc_number)
        end

        if @@payment_details.is_a? Moka::Payment::Direct3D
          required_params.push(@redirect_url)
        else
          @@payment_details.redirect_url = nil
        end

        raise Moka::Error::NullPaymentInformation if required_params.any? {|param| param.nil?}
        @@response = Moka::Request.direct_payment(@@payment_details)
        @error = Moka::Error::RequestError.new
        @error.message = @@response["ResultCode"] unless @@response["Data"]
        return @@response
      end

      def self.details(details)
        @@payment_details = details
        yield @@payment_details if block_given?
        return @@payment_details
      end

      def response
        @@response
      end

      def request_details
        @@payment_details
      end

      def success?
        if @@response["Data"]
          return true if @@response["Data"]["IsSuccessful"]
        end
        return false
      end

      def error
        @error
      end
    end
  end
end
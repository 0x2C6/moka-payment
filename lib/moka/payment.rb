require 'moka/request'
require 'moka/configuration'
require 'moka/error'

module Moka::Payment
  def self.included(base)
    base.class_eval do
      attr_accessor :dealer_code, :username, :password, :check_key,
                    :card_holder_full_name, :card_number, :exp_month, :exp_year,
                    :cvc_number, :card_token, :amount, :currency, :redirect_url, :redirect_type,
                    :client_ip, :other_trx_code, :is_pre_auth, :is_pool_payment,
                    :integrator_id, :software, :description, :sub_merchant_name, :installment_number,
                    :buyer_full_name, :buyer_email, :buyer_gsm_number, :buyer_address, :virtual_pos_order_id


      def initialize(details = {})
        @dealer_code = Moka.config.dealer_code
        @username = Moka.config.username
        @password = Moka.config.password
        @check_key = Moka.config.check_key
        @card_number = details[:card_number]
        @card_holder_full_name = details[:card_holder_full_name]
        @exp_month = details[:exp_month]
        @exp_year = details[:exp_year]
        @cvc_number = details[:cvc_number]
        @card_token = details[:card_token]
        @amount = details[:amount]
        @currency = details[:currency] || "USD"
        @redirect_url = details[:redirect_url]
        @redirect_type = details[:redirect_type]
        @installment_number = details[:installment_number] || 1
        @client_ip = details[:client_ip]
        @other_trx_code = details[:other_trx_code]
        @is_pre_auth = details[:is_pre_auth] || 0
        @is_pool_payment = details[:is_pool_payment]
        @integrator_id = details[:installment_number]
        @software = details[:software]
        @sub_merchant_name = details[:sub_merchant_name]
        @description = details[:description]
        @virtual_pos_order_id = details[:virtual_pos_order_id]
        @buyer_full_name = details[:buyer_full_name]
        @buyer_email = details[:buyer_email]
        @buyer_gsm_number = details[:buyer_gsm_number]
        @buyer_address = details[:buyer_address]
      end

      if base.to_s == "Moka::Payment::Capture"
        def capture
          @@response = Moka::Request.capture(@@payment_details)
          @@error = Moka::Error::RequestError.new
          @@error.message = @@response["ResultCode"] unless @@response["Data"]
          return @@response
        end
      else
        def pay
          raise Moka::Error::NullRedirectUrl if self.class.to_s == "Moka::Payment::Direct3D" && @@payment_details.redirect_url.nil?

          required_params = [
            @dealer_code, @username, @password, @check_key,
            @card_holder_full_name, @card_token, @amount
          ]

          unless @card_token
            required_params.delete(@card_token)
            required_params.push(@card_number, @exp_month, @exp_year, @cvc_number)
          end

          if self.class == Moka::Payment::Direct3D
            required_params.push(@redirect_url)
          else
            @@payment_details.redirect_url = nil
          end

          raise Moka::Error::NullPaymentInformation if required_params.any? {|param| param.nil?}
          @@response = Moka::Request.direct_payment(@@payment_details)
          @@error = Moka::Error::RequestError.new
          @@error.message = @@response["ResultCode"] unless @@response["Data"]
          return @@response
        end
      end

      def self.details
        @@payment_details = self.new
        yield @@payment_details if block_given?
        return @@payment_details
      end

      def response
        @@response
      end

      def request_details
        @@payment_details
      end

      def error
        @@error
      end

      def success?
        if @@response["Data"]
          return true if @@response["Data"]["IsSuccessful"]
        end
        return false
      end
    end
  end
end

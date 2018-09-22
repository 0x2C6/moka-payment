require 'moka/payment'

module Moka
  module Payment
    class Direct3D < Moka::Payment::Payment
      def initialize(details={})
        super
        @card_holder_full_name = details[:card_number]
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
        @buyer_full_name = details[:buyer_full_name]
        @buyer_email = details[:buyer_email]
        @buyer_gsm_number = details[:buyer_gsm_number]
        @buyer_address = details[:buyer_address]
      end

      def success?
       return true if @response["ResultCode"] == "Success"
       return false
      end

      def verify_payment_url
        return @response["Data"] if @response["Data"]
        return false
      end

      class << self

        def paid_successfully?(params)
          #TODO burdan qayidan hersey ucun xeta kodu var olari hamsini add ele
          unless params["isSuccessful"] == "False"
            return params
          end
          return false
        end

        def details
          @payment_details = Moka::Payment::Direct3D.new
          super @payment_details
        end
      end
    end
  end
end

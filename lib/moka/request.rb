require 'rest-client'
require 'json'
require 'pp'
require 'moka/request/pay'
require 'moka/request/get'
require 'moka/request/add'

module Moka
  module Request
    extend Moka::Request::Pay
    extend Moka::Request::Get
    extend Moka::Request::Add

    class << self
      def set_env
        $SERVICE_URL = Moka.config.env == 'production' ?
        "https://service.moka.com" :
        "https://service.testmoka.com"

        $DIRECT_PAYMENT_URL = "#{$SERVICE_URL}/PaymentDealer/DoDirectPayment"
        $DIRECT3D_PAYMENT_URL = "#{$SERVICE_URL}/PaymentDealer/DoDirectPaymentThreeD"
        $CAPTURE_PAYMENT_URL = "#{$SERVICE_URL}/PaymentDealer/DoCapture"
        $GET_PAYMENT_LIST_URL = "#{$SERVICE_URL}/PaymentDealer/GetPaymentList"
        $ADD_CUSTOMER_URL = "#{$SERVICE_URL}/DealerCustomer/AddCustomer"
      end

      def get_check_key(dealer_code, username, password)
        RestClient.get 'http://developer.moka.com/pages/checkkey.php',
         {
           params: {
             DealerCode: dealer_code,
             Username: username,
             Password: password
           }
         }
      end

      def dealer_authentication(details)
        {
          "DealerCode": details.dealer_code,
          "Username": details.username,
          "Password": details.password,
          "CheckKey": details.check_key
        }
      end

      # def capture(capture_details)
      #   payment_dealer_request = {
      #     "VirtualPosOrderId": capture_details.virtual_pos_order_id,
      #     "OtherTrxCode": capture_details.other_trx_code || "",
      #     "Amount": capture_details.amount,
      #     "ClientIP": capture_details.client_ip
      #   }
      #
      #   response = RestClient.post $CAPTURE_PAYMENT_URL,
      #   {
      #     "PaymentDealerAuthentication": dealer_authentication(capture_details),
      #     "PaymentDealerRequest": payment_dealer_request
      #   }
      #   return JSON.parse(response.body)
      # end

      # def get_payment_list(payment_list_details)
      #   payment_dealer_request = {
      #     "PaymentStartDate": payment_list_details.payment_start_date,
      #     "PaymentEndDate": payment_list_details.payment_end_date,
      #   }
      #   payment_dealer_request["PaymentStatus"] = payment_list_details.payment_status.to_i if payment_list_details.payment_status
      #   payment_dealer_request["TrxStatus"] = payment_list_details.trx_status.to_i if payment_list_details.trx_status
      #
      #   response = RestClient.post $GET_PAYMENT_LIST_URL,
      #   {
      #     "PaymentDealerAuthentication": dealer_authentication(details),
      #     "PaymentDealerRequest": payment_dealer_request
      #   }
      #   return JSON.parse(response.body)
      # end

      # def add_user(details)
      #   dealer_customer_request = {
      #     "CustomerCode": details.customer_code,
      # 		"Password": details.customer_password,
      # 		"FirstName": details.first_name,
      # 		"LastName": details.last_name,
      # 		"Gender": details.gender,
      # 		"BirthDate": details.birth_date,
      # 		"GsmNumber": details.gsm_number,
      # 		"Email": details.email,
      # 		"Address": details.address
      #   }
      #
      #   response = RestClient.post $ADD_CUSTOMER_URL,
      #   {
      #     "DealerCustomerAuthentication": dealer_authentication(details),
      #     "DealerCustomerRequest": dealer_customer_request
      #   }
      #   return JSON.parse(response.body)
      # end
    end
  end
end

require 'rest-client'
require 'json'
require 'pp'
require 'moka/request/pay'
require 'moka/request/get'
require 'moka/request/add'
require 'moka/request/update'

module Moka
  module Request
    extend Moka::Request::Pay
    extend Moka::Request::Get
    extend Moka::Request::Add
    extend Moka::Request::Update

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
        $UPDATE_CUSTOMER_URL = "#{$SERVICE_URL}/DealerCustomer/UpdateCustomer"
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
    end
  end
end

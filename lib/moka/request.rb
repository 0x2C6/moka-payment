require 'rest-client'
require 'json'
require 'pp'

module Moka
  module Request
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

      def payment_dealer_authentication(payment_details)
        {
          "DealerCode": payment_details.dealer_code,
          "Username": payment_details.username,
          "Password": payment_details.password,
          "CheckKey": payment_details.check_key
        }
      end

      def direct_payment(payment_details)
        payment_dealer_request = {
          "CardHolderFullName": payment_details.card_holder_full_name,
          "CardNumber": payment_details.card_number,
          "ExpMonth": payment_details.exp_month,
          "ExpYear": payment_details.exp_year,
          "CvcNumber": payment_details.cvc_number,
          "Amount": payment_details.amount,
          "Currency": payment_details.currency,
          "InstallmentNumber": payment_details.installment_number,
          "IsPreAuth": payment_details.is_pre_auth
        }

        ["CardNumber", "ExpMonth", "ExpMonth", "CvcNumber"].each do |detail|
          payment_dealer_request.delete(detail.to_sym)
        end && payment_dealer_request["CardToken"] = payment_details.card_token if payment_details.card_token

        payment_dealer_request["RedirectUrl"] = payment_details.redirect_url if payment_details.redirect_url
        payment_dealer_request["RedirectType "] = payment_details.redirect_type if payment_details.redirect_type
        payment_dealer_request["ClientIP"] = payment_details.client_ip if payment_details.client_ip
        payment_dealer_request["OtherTrxCode"] = payment_details.other_trx_code if payment_details.other_trx_code
        payment_dealer_request["IsPoolPayment"] = payment_details.is_pool_payment if payment_details.is_pool_payment
        payment_dealer_request["IntegratorId"] = payment_details.integrator_id if payment_details.integrator_id
        payment_dealer_request["Software"] = payment_details.software if payment_details.software
        payment_dealer_request["Description"] = payment_details.description if payment_details.description

        buyer_information = {}
        buyer_information["BuyerFullName"] = payment_details.buyer_full_name if payment_details.buyer_full_name
        buyer_information["BuyerEmail"] = payment_details.buyer_email if payment_details.buyer_email
        buyer_information["BuyerGsmNumber"] = payment_details.buyer_gsm_number if payment_details.buyer_gsm_number
        buyer_information["BuyerAddress"] = payment_details.buyer_address if payment_details.buyer_address

        response = RestClient.post payment_details.redirect_url ? $DIRECT3D_PAYMENT_URL : $DIRECT_PAYMENT_URL,
        {
          "PaymentDealerAuthentication": payment_dealer_authentication(payment_details),
          "PaymentDealerRequest": payment_dealer_request,
          "BuyerInformation": buyer_information
        }
        return JSON.parse(response.body)
      end

      def capture(capture_details)
        payment_dealer_request = {
          "VirtualPosOrderId": capture_details.virtual_pos_order_id,
          "OtherTrxCode": capture_details.other_trx_code || "",
          "Amount": capture_details.amount,
          "ClientIP": capture_details.client_ip
        }

        response = RestClient.post $CAPTURE_PAYMENT_URL,
        {
          "PaymentDealerAuthentication": payment_dealer_authentication(capture_details),
          "PaymentDealerRequest": payment_dealer_request
        }
        return JSON.parse(response.body)
      end

      def get_payment_list(payment_list_details)
        payment_dealer_request = {
          "PaymentStartDate": payment_list_details.payment_start_date,
          "PaymentEndDate": payment_list_details.payment_end_date,
        }
        payment_dealer_request["PaymentStatus"] = payment_list_details.payment_status.to_i if payment_list_details.payment_status
        payment_dealer_request["TrxStatus"] = payment_list_details.trx_status.to_i if payment_list_details.trx_status

        response = RestClient.post $GET_PAYMENT_LIST_URL,
        {
          "PaymentDealerAuthentication": payment_dealer_authentication(payment_details),
          "PaymentDealerRequest": payment_dealer_request
        }
        return JSON.parse(response.body)
      end

      def add_user(customer_details)
        dealer_customer_authentication = {
          "DealerCode": customer_details.dealer_code,
          "Username": customer_details.username,
          "Password": customer_details.password,
          "CheckKey": customer_details.check_key
        }

        dealer_customer_request = {
          "CustomerCode": customer_details.customer_code,
      		"Password": customer_details.customer_password,
      		"FirstName": customer_details.first_name,
      		"LastName": customer_details.last_name,
      		"Gender": customer_details.gender,
      		"BirthDate": customer_details.birth_date,
      		"GsmNumber": customer_details.gsm_number,
      		"Email": customer_details.email,
      		"Address": customer_details.address
        }

        response = RestClient.post $ADD_CUSTOMER_URL,
        {
          "DealerCustomerAuthentication": dealer_customer_authentication,
          "DealerCustomerRequest": dealer_customer_request
        }
        return JSON.parse(response.body)
      end
    end
  end
end

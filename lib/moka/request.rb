require 'rest-client'
require 'json'

module Moka
  module Request
    DIRECT_PAYMENT_URL = "https://service.testmoka.com/PaymentDealer/DoDirectPayment"
    DIRECT3D_PAYMENT_URL = "https://service.testmoka.com/PaymentDealer/DoDirectPaymentThreeD"
    class << self

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

      def direct_payment(payment_details)
        payment_dealer_authentication = {
          "DealerCode": payment_details.dealer_code,
          "Username": payment_details.username,
          "Password": payment_details.password,
          "CheckKey": payment_details.check_key
        }

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


        response = RestClient.post payment_details.redirect_url ? DIRECT3D_PAYMENT_URL : DIRECT_PAYMENT_URL,
        {
          "PaymentDealerAuthentication": payment_dealer_authentication,
          "PaymentDealerRequest": payment_dealer_request,
          "BuyerInformation": buyer_information
        }
        return JSON.parse(response.body)
      end

    end

  end
end

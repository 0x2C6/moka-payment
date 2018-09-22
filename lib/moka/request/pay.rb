module Moka
  module Request
    module Pay
      def direct_payment(details)
        payment_dealer_request = {
          "CardHolderFullName": details.card_holder_full_name,
          "CardNumber": details.card_number,
          "ExpMonth": details.exp_month,
          "ExpYear": details.exp_year,
          "CvcNumber": details.cvc_number,
          "Amount": details.amount,
          "Currency": details.currency,
          "InstallmentNumber": details.installment_number,
          "IsPreAuth": details.is_pre_auth
        }

        ["CardNumber", "ExpMonth", "ExpMonth", "CvcNumber"].each do |detail|
          payment_dealer_request.delete(detail.to_sym)
        end && payment_dealer_request["CardToken"] = details.card_token if details.card_token

        payment_dealer_request["RedirectUrl"] = details.redirect_url if details.redirect_url
        payment_dealer_request["RedirectType "] = details.redirect_type if details.redirect_type
        payment_dealer_request["ClientIP"] = details.client_ip if details.client_ip
        payment_dealer_request["OtherTrxCode"] = details.other_trx_code if details.other_trx_code
        payment_dealer_request["IsPoolPayment"] = details.is_pool_payment if details.is_pool_payment
        payment_dealer_request["IntegratorId"] = details.integrator_id if details.integrator_id
        payment_dealer_request["Software"] = details.software if details.software
        payment_dealer_request["Description"] = details.description if details.description

        buyer_information = {}
        buyer_information["BuyerFullName"] = details.buyer_full_name if details.buyer_full_name
        buyer_information["BuyerEmail"] = details.buyer_email if details.buyer_email
        buyer_information["BuyerGsmNumber"] = details.buyer_gsm_number if details.buyer_gsm_number
        buyer_information["BuyerAddress"] = details.buyer_address if details.buyer_address

        response = RestClient.post details.redirect_url ? $DIRECT3D_PAYMENT_URL : $DIRECT_PAYMENT_URL,
        {
          "PaymentDealerAuthentication": dealer_authentication(details),
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
          "PaymentDealerAuthentication": dealer_authentication(capture_details),
          "PaymentDealerRequest": payment_dealer_request
        }
        return JSON.parse(response.body)
      end
      
    end
  end
end

module Moka::Request::Get
  def get_payment_list(payment_list_details)
    payment_dealer_request = {
      "PaymentStartDate": payment_list_details.payment_start_date,
      "PaymentEndDate": payment_list_details.payment_end_date,
    }
    payment_dealer_request["PaymentStatus"] = payment_list_details.payment_status.to_i if payment_list_details.payment_status
    payment_dealer_request["TrxStatus"] = payment_list_details.trx_status.to_i if payment_list_details.trx_status

    response = RestClient.post $GET_PAYMENT_LIST_URL,
    {
      "PaymentDealerAuthentication": dealer_authentication(details),
      "PaymentDealerRequest": payment_dealer_request
    }
    return JSON.parse(response.body)
  end
end

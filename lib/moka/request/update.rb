module Moka::Request::Update
  def update_customer(details)
    dealer_customer_request = {
      "DealerCustomerId": details.dealer_customer_id,
      "CustomerCode": details.customer_code,
      "Password": details.customer_password,
      "FirstName": details.first_name,
      "LastName": details.last_name,
      "Gender": details.gender,
      "BirthDate": details.birth_date,
      "GsmNumber": details.gsm_number,
      "Email": details.email,
      "Address": details.address
    }

    response = RestClient.post $UPDATE_CUSTOMER_URL,
    {
      "DealerCustomerAuthentication": dealer_authentication(details),
      "DealerCustomerRequest": dealer_customer_request
    }
    return JSON.parse(response.body)
  end
end
module Moka::Request::Add
  def add_user(details)
    dealer_customer_request = {
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

    response = RestClient.post $ADD_CUSTOMER_URL,
    {
      "DealerCustomerAuthentication": dealer_authentication(details),
      "DealerCustomerRequest": dealer_customer_request
    }
    return JSON.parse(response.body)
  end
end

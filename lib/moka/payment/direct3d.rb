require 'moka/payment'

class Moka::Payment::Direct3D
  include Moka::Payment

  def success?
   return true if @@response["ResultCode"] == "Success"
   return false
  end

  def verify_payment_url
    return @@response["Data"] if @@response["Data"]
    return false
  end

  def self.paid_successfully?(params)
    unless params["isSuccessful"] == "False"
      return params
    end
    return false
  end
end

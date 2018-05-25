require 'moka/request'
require 'moka/configuration'

module Moka
  module Add
    class Customer
      attr_accessor :dealer_code, :username, :password, :check_key,
                    :customer_code, :customer_password, :first_name,
                    :last_name, :gender, :birth_date, :gsm_number,
                    :email, :address

      def initialize(details = {})
        @dealer_code = Moka.config.dealer_code
        @username = Moka.config.username
        @password = Moka.config.password
        @check_key = Moka.config.check_key
        @customer_code = details[:customer_code]
        @customer_password = details[:customer_password]
        @first_name = details[:first_name]
        @last_name = details[:last_name]
        @gender = details[:gender]
        @birth_date = details[:birth_date]
        @gsm_number = details[:gsm_number]
        @email = details[:email]
        @address = details[:address]
      end

      def self.details
        @@response = nil
        @@customer_details = Moka::Add::Customer.new
        yield @@customer_details if block_given?
        return @@customer_details
      end

      def add
        @@response = Moka::Request.add_user(@@customer_details)
      end

      def response
        @@response
      end

      def request_details
        @@customer_details
      end

      def success?
       if @@response["ResultCode"] == "Success"
         return true
       end if @@response
       return false
      end

    end
  end
end

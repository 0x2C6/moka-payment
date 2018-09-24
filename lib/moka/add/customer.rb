require 'moka/request'
require 'moka/configuration'
require 'moka/error'

module Moka
  module Add
    class Customer
      attr_accessor :dealer_code, :username, :password, :check_key,
                    :customer_code, :customer_password, :first_name,
                    :last_name, :gender, :birth_date, :gsm_number,
                    :email, :address
      attr_reader   :dealer_customer_id, :card_list_count, :card_list

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
        @dealer_customer_id = nil
        @card_list_count = nil
        @card_list = nil
      end

      def self.details
        @@response = nil
        @@customer_details = Moka::Add::Customer.new
        yield @@customer_details if block_given?
        return @@customer_details
      end

      def add
        raise Moka::Error::NullRequiredParameter if [@customer_code, @first_name].any? { |d| d.nil? } 
        @@response = Moka::Request.add_customer(@@customer_details)
        if success?
          @dealer_customer_id = @@response["Data"]["DealerCustomer"]["DealerCustomerId"]
          @card_list_count = @@response["Data"]["CardListCount"]
          @card_list = @@response["Data"]["CardList"]
        else
          @error = Moka::Error::RequestError.new
          @error = @@response["ResultCode"] unless @@response["Data"]
        end
        return @@response
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

      def error
        @error
      end
    end
  end
end

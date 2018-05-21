require 'moka/request'
require 'moka/error'

module Moka
  class Dealer
    attr_accessor :dealer_code, :username, :password, :check_key

    def initialize(dealer_code = nil, username = nil, password = nil)
      @dealer_code = dealer_code
      @username = username
      @password = password
    end

    def get_check_key
      return @check_key = Moka::Request.get_check_key(
          @dealer_code, @username, @password
        ).body unless [ @dealer_code, @username, @password ].any? { |key| key.nil? }
      raise "Error" # Hamsi gonderilmelidi ona uygun xeta yarad
    end

  end
end

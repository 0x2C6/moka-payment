require 'moka/request'
require 'moka/error'

module Moka
  class Dealer
    attr_accessor :dealer_code, :username, :password, :env, :check_key

    def initialize(dealer_code = nil, username = nil, password = nil, env = nil)
      @dealer_code = dealer_code
      @username = username
      @password = password
      @env = env
    end

    def get_check_key
      required_params = [ @dealer_code, @username, @password ]
      raise Moka::Error::NullRequiredParameter if required_params.any? { |params| params.nil? }
      return @check_key = Moka::Request.get_check_key(
          @dealer_code, @username, @password
        ).body
    end
  end
end

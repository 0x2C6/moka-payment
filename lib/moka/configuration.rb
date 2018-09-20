require 'moka/dealer'
require 'moka/request'

module Moka
  module Configuration
    def configure(options = { env: ENV['RACK_ENV'] }) #TODO bos gelse ne olacaq?
      @config = Moka::Dealer.new
      @config.env = options[:env] ? options[:env].to_s : 'production'
      Moka::Request::set_env
      yield @config if block_given?
      @config.get_check_key
    end

    def config
      @config if @config
    end
  end
end

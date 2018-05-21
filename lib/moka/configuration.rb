require 'moka/dealer'

module Moka
  module Configuration
    
    def configure
      @config = Moka::Dealer.new
      yield @config if block_given?
      @config.get_check_key
    end

    def config
      @config if @config
    end

  end
end

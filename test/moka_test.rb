require 'test_helper'
require 'digest'

module Moka
  class Test < Minitest::Test
    def setup
      Moka.configure env: :test do |config|
        config.dealer_code = ENV['MOKA_DEALER_CODE']
        config.username = ENV['MOKA_USERNAME']
        config.password = ENV['MOKA_PASSWORD']
      end
    end

    def test_should_get_moka_informations_and_return_check_key
      assert_equal Moka.config.dealer_code, ENV['MOKA_DEALER_CODE']
      assert_equal Moka.config.username, ENV['MOKA_USERNAME']
      assert_equal Moka.config.password, ENV['MOKA_PASSWORD']
      assert_equal Moka.config.check_key, Digest::SHA256.hexdigest "#{ENV['MOKA_DEALER_CODE']}MK#{ENV['MOKA_USERNAME']}PD#{ENV['MOKA_PASSWORD']}"
    end
  end
end

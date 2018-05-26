require "test_helper"
require 'pp'

module Moka
  class Test < Minitest::Test
    include Minitest::Hooks
    def setup
      Moka.configure do |config|
        config.dealer_code = "123456"
        config.username = "ZXCVBNVBN"
        config.password = "abcdef"
      end
    end

    def test_should_get_moka_informations_and_return_check_key
      assert_equal Moka.config.dealer_code, "123456"
      assert_equal Moka.config.username, "ZXCVBNVBN"
      assert_equal Moka.config.password, "YHSUSHDYHUDHD"
      assert_equal Moka.config.check_key, "ff4a6ee22aeafe87f7930f84b5ce2ad9655bfc6b5e430644a88c5b75a09fdee1"
    end
  end
end

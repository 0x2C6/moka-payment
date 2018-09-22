require "test_helper"
require 'pp'

module Moka
  class Test < Minitest::Test
    def setup
      Moka.configure env: :test do |config|
        config.dealer_code = "1730"#ENV['MOKA_DEALER_CODE']
        config.username = "TestKorhan"#ENV['MOKA_USERNAME']
        config.password = "YHSUSHDYHUDHD"#ENV['MOKA_PASSWORD']
      end
    end

    def test_should_get_moka_informations_and_return_check_key
      assert_equal Moka.config.dealer_code, "1730"#ENV['MOKA_DEALER_CODE']
      assert_equal Moka.config.username, "TestKorhan"#ENV['MOKA_USERNAME']
      assert_equal Moka.config.password, "YHSUSHDYHUDHD"#ENV['MOKA_PASSWORD']
      assert_equal Moka.config.check_key, "73bbf2fc412ed0eaf47796e2784fbb86b60267da84c92a17d8ddb408cb5a6461" #"ff4a6ee22aeafe87f7930f84b5ce2ad9655bfc6b5e430644a88c5b75a09fdee1"
    end
  end
end

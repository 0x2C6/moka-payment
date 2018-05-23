require "test_helper"
require 'pp'

module Moka
  class Test < Minitest::Test
    include Minitest::Hooks
    def setup
      Moka.configure do |config|
        config.dealer_code = "1730"
        config.username = "TestKorhan"
        config.password = "YHSUSHDYHUDHD"
      end
    end

    def test_should_get_moka_informations_and_return_check_key
      assert_equal Moka.config.dealer_code, "1730"
      assert_equal Moka.config.username, "TestKorhan"
      assert_equal Moka.config.password, "YHSUSHDYHUDHD"
      assert_equal Moka.config.check_key, "73bbf2fc412ed0eaf47796e2784fbb86b60267da84c92a17d8ddb408cb5a6461"
    end
  end
end

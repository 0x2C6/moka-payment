module Moka
  module Error
    class RequestError < StandardError
      attr_accessor :message

      def initialize(message = nil)
        @message = message
      end

      def to_s
        "You have an error #{@message}" if @message
      end
    end

    class NullPaymentInformation < StandardError; end
    class NullRedirectUrl < StandardError; end
  end
end

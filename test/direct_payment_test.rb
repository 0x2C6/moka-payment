require "moka_test"

class MokaDirectPaymentTest < Moka::Test
  def setup
    super
    @direct_payment = Moka::Payment::Direct.payment_details do |detail|
      detail.card_holder_full_name = "Ali Yılmaz"
      detail.card_number = "5269552233334444"
      detail.exp_month = "12"
      detail.exp_year = "2022"
      detail.cvc_number = "123"
      detail.amount = 35.5
      detail.currency = "TL"
      detail.installment_number = "1"
      detail.client_ip = "195.155.96.234"
      detail.other_trx_code = "123456"
      detail.is_pre_auth = 0
      detail.is_pool_payment = 0
      detail.integrator_id = 1
      detail.software = "OpenCart"
      detail.sub_merchant_name = "Company"
      detail.description = "Test Description"
      detail.buyer_full_name = "Elif Yetimoğlu"
      detail.buyer_email = "test@test.com"
      detail.buyer_gsm_number = "1111111111"
      detail.buyer_address = "New York City"
    end
  end

  def test_should_pay_direct_successfully
    @direct_payment.pay
    puts @direct_payment.response
    assert @direct_payment.success?
    assert !@direct_payment.errors.message
  end

  def test_should_decline_payment
    @direct_payment.card_number = "5555666677778888"
    @direct_payment.pay
    assert !@direct_payment.success?
  end

  def test_should_return_request_error
    @direct_payment.card_number = "5555666677778888"
    @direct_payment.pay
    assert_equal @direct_payment.errors.message, "PaymentDealer.CheckCardInfo.InvalidCardInfo"
  end

  def test_should_raise_null_payment_information_error
    @direct_payment.card_number = nil
    assert_raises Moka::Error::NullPaymentInformation do
      @direct_payment.pay
    end
  end
end

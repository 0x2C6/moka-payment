require 'moka_test'
require 'pp'

class MokaDirect3DPaymentTest < Moka::Test
  def setup
    super
    @direct_payment = Moka::Payment::Direct3D.details do |detail|
      detail.card_holder_full_name = "Ali Yılmaz"
      detail.card_number = "5269552233334444"
      detail.exp_month = "12"
      detail.exp_year = "2022"
      detail.cvc_number = "123"
      detail.amount = 35.5
      detail.currency = "TL"
      detail.redirect_url = "http://aaaa.com"
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

  def test_should_pay_direct3d_successfully
    @direct_payment.pay
    assert @direct_payment.success?
  end

  def test_should_raise_null_redirect_url
    @direct_payment.redirect_url = nil
    assert_raises Moka::Error::NullRedirectUrl do
      @direct_payment.pay
    end
  end

end

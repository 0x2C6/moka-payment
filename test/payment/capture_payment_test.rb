require 'moka_test'

class MokaCapturePaymentTest < Moka::Test
  def setup
    super
    @capture_payment = Moka::Payment::Capture.details do |detail|
      detail.virtual_pos_order_id = "Test-99622117-5834-4d0e-8248-849a33b6bdcf"
      detail.other_trx_code = ""
      detail.amount = 35.5
      detail.client_ip = "195.155.96.234"
    end
  end

  def test_should_raise_not_direct_or_direct3d_error
    assert_raises Moka::Error::NotDirectOrDirect3DPayment do
      @capture_payment.pay
    end
  end

  def test_should_decline_capture
    @capture_payment.virtual_pos_order_id = "Test-99622117-5834-4d0e-8248-849a33b6bdcf"
    @capture_payment.capture
    assert !@capture_payment.success?
    assert_equal @capture_payment.error.message, "PaymentDealer.DoCapture.CaptureNotAvailable"
  end

end

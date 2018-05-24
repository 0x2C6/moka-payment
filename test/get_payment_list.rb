require "minitest"

class MokaGetPaymentListTest < Moka::Test
  def setup
    super
    @payment_list = Moka::Get::PaymentList.details do |detail|
      detail.payment_start_date = "2018-05-23 14:00"
      detail.payment_end_date = "2018-05-24 08:00"
    end
  end

  def test_should_get_payment_list_successfully
    @payment_list.get_list
    assert @payment_list.success?
    assert @payment_list.list_count > 0
  end

  def test_should_not_get_payment_list
    @payment_list.username = "test"
    @payment_list.get_list
    assert !@payment_list.success?
    assert @payment_list.list_count == 0
  end

end

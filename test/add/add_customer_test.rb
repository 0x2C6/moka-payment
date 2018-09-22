require 'moka_test'
require 'pp'

class MokaAddCusomerTest < Moka::Test
  def setup
    super
    @customer = Moka::Add::Customer.details do |detail|
      detail.customer_code = "Customer#{rand 10..1000}"
      detail.customer_password = "1245334334"
      detail.first_name = "sewedffewfewf"
      detail.last_name = "wefwfwfwfwefe"
      detail.gender = "2"
      detail.birth_date = "19901218"
      detail.gsm_number = "5301111111"
      detail.email = "elif.y@moka.com"
      detail.address = "TAŞDELEN"
    end
  end

  def test_should_add_new_customer
    @customer.add
    assert @customer.success?
    assert_equal @customer.card_list_count.to_s, "0"
  end

  def test_should_not_add_new_customer
    @customer.customer_code = "Customer"
    @customer.add
    assert !@customer.success?
    assert_equal @customer.errors, "DealerCustomer.AddCustomer.CustomerCodeAlreadyUsing"
  end

  def test_should_raise_error
    @customer.first_name = nil
    assert_raises Moka::Error::NullRequiredParameter do
      @customer.add
    end
  end
end

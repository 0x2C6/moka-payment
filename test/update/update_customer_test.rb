require 'moka_test'
require 'pp'

class MokaUpdateCusomerTest < Moka::Test
  def setup
    super
    @customer = Moka::Update::Customer.details do |detail|
      detail.customer_code = "Customer"
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

  def test_should_update_customer
    @customer.update
    assert @customer.success?
  end

  def test_should_rails_error
    @customer.customer_code = nil
    assert_raises Moka::Error::NullRequiredParameter do
      @customer.update
    end
  end
end

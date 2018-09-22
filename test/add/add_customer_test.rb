require 'moka_test'
require 'pp'

class MokaAddCusomerTest < Moka::Test
  def setup
    super
  end

  def test_should_add_new_customer
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

    @customer.add
    assert @customer.success?
    assert_equal @customer.card_list_count.to_s, "0"
  end
end

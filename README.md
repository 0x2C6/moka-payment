# Moka
[![Progress](http://progressed.io/bar/12?title=completed)](http://progressed.io/bar/12?title=completed) [![Gem Version](https://badge.fury.io/rb/moka-payment.svg)](https://badge.fury.io/rb/moka-payment)

MOKA'nın ödeme alma, ödeme isteği gönderme, kart saklama ve tekrarlayan ödeme servisleri ile ödemelerinizi alabilirsiniz.
[Üye](https://mokapos.moka.com/) olun ve Moka'yı kullanmaya hemen başlayın!

## Kurulum

Moka'yı Gemfile içine dahil edin

```ruby
gem 'moka-payment'
```

Gerekli paketlerin tamamen kurulduğundan emin olun

    $ bundle

Veya kendiniz kurun

    $ gem install moka-payment

## Kullanım
İlk önce Moka'dan aldığınız bayi numarasını, kullanıcı adınızı ve parolanızı tanıtmanız gerekiyor

```ruby
require 'moka'

Moka.configure do |config|
  config.dealer_code = "123456"
  config.username = "ZXCVBNVBN"
  config.password = "abcdef"
end
```
Şimdi ilk ödememizi yapabiliriz
```ruby
@payment = Moka::Payment::Direct.details do |detail|
  detail.card_holder_full_name = "Ali Yılmaz"
  detail.card_number = "5269552233334444"
  detail.exp_month = "12"
  detail.exp_year = "2022"
  detail.cvc_number = "123"
  detail.amount = 35.5
  detail.currency = "TL"
  detail.client_ip = "195.155.96.234"
  detail.software = "OpenCart"
  detail.sub_merchant_name = "Company"
  detail.description = "Test Description"
  detail.buyer_full_name = "Elif Yetimoğlu"
  detail.buyer_email = "test@test.com"
  detail.buyer_gsm_number = "1111111111"
  detail.buyer_address = "New York City"
end

@payment.pay

if @payment.success?
    puts "Ödeme başarı ile tamamlanmıştır"
end
```
Daha detaylı bilgi için wiki kısmına ve resmi Moka dökümantasyonuna göz atın.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/0x2C6/moka-payment.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

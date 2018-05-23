# Moka

MOKA ile ödeme alma, ödeme isteği gönderme, kart saklama servisleri ve tekrarlayan ödeme servisleri ile ödemelerinizi alabilirsiniz.
[Üye](https://mokapos.moka.com/) olun Moka yı kullanmaya hemen başlayın!

## Kurulum

Moka yı Gemfile içine dahil edin

```ruby
gem 'moka-payment'
```

Gerekli paketlerin tamamen kurulduğundan emin olun

    $ bundle

Ve ya kendiniz kurun

    $ gem install moka

## Kullanım
İlk önce Moka dan aldığınız Bayi id Kullanıcı Adı ve Şifrenizi tanıtmanız gerekiyor

```ruby
Moka.configure do |config|
  config.dealer_code = "123456"
  config.username = "ZXCVBNVBN"
  config.password = "abcdef"
end
```
Şimdi ilk ödememizi yapa biliriz
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
Daha detaylı bilgi için wiki kısmına ve resmi Moka Dokümantasyonuna göz atın.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/moka.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

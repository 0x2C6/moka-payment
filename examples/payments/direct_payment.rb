#!/usr/bin/env ruby

$: << File.expand_path('./lib')
require 'moka'

Moka.configure env: :test do |config|
  config.dealer_code = ENV['MOKA_DEALER_CODE']
  config.username = ENV['MOKA_USERNAME']
  config.password = ENV['MOKA_PASSWORD']
end

direct_payment = Moka::Payment::Direct.details do |detail|
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

direct_payment.pay
puts direct_payment.response

if direct_payment.success?
  puts "Paid Succesfully"
else
  puts "Payment Declined"
end
puts direct_payment.error
pp direct_payment.request_details

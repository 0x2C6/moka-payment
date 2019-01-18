#!/usr/bin/env ruby

$: << File.expand_path('./lib')
require 'moka'

Moka.configure env: :test do |config|
  config.dealer_code = ENV['MOKA_DEALER_CODE']
  config.username = ENV['MOKA_USERNAME']
  config.password = ENV['MOKA_PASSWORD']
end

capture_payment = Moka::Payment::Capture.details do |detail|
  detail.virtual_pos_order_id = "Your-Virtual-Pos-Order-ID"
  detail.other_trx_code = ""
  detail.amount = 35.5
  detail.client_ip = "195.155.96.234"
end

capture_payment.capture
puts capture_payment.response

if capture_payment.success?
  puts "Captured Succesfully"
else
  puts "Capture Declined"
end
puts capture_payment.error
pp capture_payment.request_details

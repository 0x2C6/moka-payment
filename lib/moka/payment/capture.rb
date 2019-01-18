require 'moka/payment'

class Moka::Payment::Capture
  include Moka::Payment
  #                         Capture İşlemi (Ön Provizyonu Satışa Dönüştürme)
  #
  #                             Servis Adresi: /PaymentDealer/DoCapture
  #
  #                                   PaymentDealerAuthentication
  #
  # dealer_code: (string)	Moka sistemi tarafından verilen bayi kodu
  # username:    (string) Moka sistemi tarafından verilen Api kullanıcı adı
  # password:    (string) Moka sistemi tarafından verilen Api şifresi
  #
  #                                   PaymentDealerRequest
  # virtual_pos_order_id: (string) Ön Provizyon alma işlemi sonucunda dönen işlem numarası bilgisidir.
  #                                 3D ödemelerde trxCode ismiyle dönülen numaradır.
  #                                 Key: trxCode     Value : ORDER-17131QQFG04026575
  # other_trx_code:       (string)	Ön Provizyon işlemi gönderirken bayinin, kendine ait verdiği Unique işlem numarasıdır.
  #                                 VirtualPosOrderId verilmişse bu numarayı boş gönderebilirsiniz. Ya da kendi Unique numaranızı
  #                                 kullanmak istiyorsanız VirtualPosOrderId alanını boş gönderebilirsiniz.
  # amount:               (float)   Ön Provizyon kapatma tutarı (Kuruş kısmı nokta ile yazılır. Örn: 27.50) Bu tutar alınan provizyona eşit ya da küçük olabilir
  # client_ip:            (string)	Ön Provizyonu kapatan uygulamanın (desktop/web) çalıştırıldığı bilgisayarın IP bilgisi
  #
  # Kullanıla bilir methodlar.
  #
  # def capture
  #   Capture işlemini sunucuya gönderir.
  # end
  #
  # def success?
  #   "Data" içinde yer alan "IsSuccessful" (true/false) alanı kontrol edilerek işlemin durumu kontrol edilir.
  #   "IsSuccessful" içindeki boolean değer döner.
  # end
  #
  # def request_details
  #   Sunucuye gönderilmiş nesnenin kopyası döner.
  # end
  #
  # def response
  #   Sunucudan alınan raw nesne döner.
  # end
  #
  # def error
  #   Sunucudan alıan hata döner.
  # end
end

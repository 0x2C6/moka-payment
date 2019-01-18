require 'moka/payment'

class Moka::Payment::Direct
  include Moka::Payment
  #                           3D Secure Olmadan Ödeme (Non-3D Ödeme)
  #
  #                        Servis Adresi: /PaymentDealer/DoDirectPayment
  #
  #                               PaymentDealerAuthentication
  #
  # dealer_code: (string)	Moka sistemi tarafından verilen bayi kodu
  # username:    (string) Moka sistemi tarafından verilen Api kullanıcı adı
  # password:    (string) Moka sistemi tarafından verilen Api şifresi
  #
  #                                  PaymentDealerRequest
  #
  # card_holder_full_name: (string)  Kart sahibinin adı soyadı
  # card_number:           (string)  Kart numarası
  # exp_month:             (string)  Son kullanma tarihi ay bilgisi (MM)
  # exp_year:              (string)  Son kullanma tarihi yıl bilgisi (YYYY)
  # cvc_number:            (string)  Kart güvenlik numarası
  # card_token:            (string)  Moka üzerinde Kart saklama özelliği kullanılıyorsa, Kartın Token’ ı
  #                                  verilerek çekim yapılabilir. Token verilmişse, kart numarası ve diğer
  #                                  kart bilgilerinin (son kul. tarihi, cvc) verilmesine gerek yoktur.
  # amount:                (float)   Ödeme tutarı (Kuruş kısmı nokta ile yazılır. Örn: 27.50)
  # currency:              (string)  Para birimi. Opsiyonel alandır, hiç gönderilmezse veya boş gönderilirse,
  #                                  default’ u TL dir, Diğer değerler : USD, EUR, GBP
  # installment_number:    (integer) Taksit Sayısı. Opsiyonel alandır, hiç gönderilmezse, boş gönderilirse, 0 veya
  #                                  1 gönderilirse Peşin satış demektir, Taksit için 2 ile 12 arasında bir değer gönderilmelidir.
  # client_ip:             (string)  Kart numarasının alındığı uygulamanın (desktop/web) çalıştırıldığı bilgisayarın IP bilgisi
  # other_trx_code:        (string)  Mütabakat sağlamak için kendi Unique Transaction (İşlem) Kodunuzu bu alanda gönderebilirsiniz.
  #                                  (Boş da gönderilebilir). Not : Bayi ödeme detay listesi alırken bu kodunuzu kullanarak Ödeme durumunu öğrenebilirsiniz.
  # is_pre_auth:           (integer) 0 : Doğrudan Çekim İşlemi
  #                                  1 : Ön Provizyon Alma İşlemi (Bir süre sonra DoCapture servisi ile ödemeye dönüştürülmeli)
  # is_pool_payment:       (integer) Para kredi kartından çekilecek fakat havuzda bekletilecek. Bayi, müşteri hizmet veya ürünü
  #                                  teslim aldıktan sonra ödemeyi onaylayacak ve bu işlemle ilgili ödeme onaydan sonra bayinin
  #                                  ekstresine yansıyacak (opsiyonel). Havuz sisteminde bir ödeme göndermek için bu alanı 1 yapınız.
  # integrator_id:         (integer) Hazır ETicaret paketlerine Moka entegrasyonu yapan Sistem Entegratörü Firmanın ID si – (Entegratör firma değilseniz bu alanı göndermeyiniz !)
  # software:              (string) Moka ödeme sistemiyle entegre çalışan, bu servisi çağırdığınız E-ticaret paketinin veya yazılımınızın ismi. (Max 30 karakter)
  # sub_merchant_name:     (string) Ekstrede görünmesini istediğiniz isim – Mokaya önceden bildirilmeli
  # description:           (string) Açıklama alanıdır. Ödemeye ilişkin bir açıklama yazmak istenirse bu alana yazılabilir.(200 karaktere kadar yazılabilir.)
  #
  #                         BuyerInformation (Array)(opsiyonel)
  #
  # Bayimizden Ürün/Hizmet satın alan müşterisi ile ilgili alanlardır.
  # Bu alanların gönderilmesi zorunlu olmamasına karşın, Moka ile paylaşılması,
  # ileride ödemeyle ilgili oluşabilecek sorunlara karşı, hem bayimizin hem de Moka' nın menfaatinedir.
  #
  # buyer_full_name:   (string)  Opsiyonel alandır.Alıcının adı ve soyadıdır.
  # buyer_email:       (string)  Opsiyonel alandır.Alıcının eposta adresidir.
  # buyer_gsm_number:  (string)  Opsiyonel alandır.Alıcının cep telefonu numarasıdır.
  # buyer_address:     (string)  Opsiyonel alandır.Alıcının adresidir.

  # Kullanıla bilir methodlar.
  #
  # def pay
  #   Ödeme işlemini sunucuya gönderir.
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

# MP TV Test ve Uyumluluk Notları

## 2.0.2 Doğrulaması

- 80 otomatik test, imzalı release derlemesi ve Android lint kontrolü tamamlandı.
- Emülatörde dört gerçek TV yayınıyla çoklu gösterim, boş durum katmanlarının kaldırılması, filigran ve kontrolleri gizleyip geri getirme denendi.
- ONVIF keşif ekranı ve taklit Media1 yanıtlarıyla profil/RTSP adresi alışverişi test edildi. Gerçek kamera/NVR donanımıyla marka-model doğrulaması yapılmadı.

## APK Güncellemesi

Android 9 ve 10 testlerinde eski 2.0.0 APK'sı doğru imzalı yeni sürümü reddetti. İmza okuma uyumluluğu 2.0.2'de düzeltildi; güvenlik kontrolleri kaldırılmadı.

Düzeltilmiş kodu içeren, sürüm kodu 21 olan özel test kurulumundan GitHub'daki 2.0.2'ye uygulama içi indirme, bütünlük/imza doğrulaması, Android kurulum izni ve gerçek APK kurulumu tamamlandı. Cihazda sürüm kodu 22 ve sürüm adı 2.0.2 doğrulandı.

Bu, hatalı eski 2.0.0 APK'sından otomatik geçişin çalıştığı anlamına gelmez. 2.0.0/2.0.1 kullanıcıları ilk geçişte APK'yı elle indirip mevcut uygulamanın üzerine kurmalıdır.

## Kapsam Sınırları

| Başlık | Sınır |
| --- | --- |
| 32 bölme | 32 eşzamanlı akış için performans garantisi değildir. |
| ONVIF | Her marka, firmware ve NVR kanal profili için saha uyumluluğu doğrulanmadı. |
| RTSP | H.264 tercih edilir; H.265 uyumluluğu varsayılmamalıdır. |
| VOD | M3U video bağlantıları; Xtream katalog ve DRM servis girişleri yoktur. |
| EPG | Kanal eşleşmesi ve güncel program verisi gerekir. |
| Canlı pause | Kalıcı DVR/kayıt değildir; canlı noktaya dönülebilir. |
| NVR | Canlı görüntü izleyici; arşiv, PTZ, alarm ve cihaz yönetimi yoktur. |
| Hazır kameralar | Anlık erişim kontrolü gelecekte kesintisiz yayın garantisi değildir. |

## Görseller

Ürün sayfası gerçek uygulama ekranlarını kullanır. İlk açılış, VOD ve kaynak yönetimi 2.0.2'den; dört yayınlı tam ekran çoklu görünüm aynı özelliğin 2.0.1 testinden alınmıştır. Görsellerde gerçek kullanıcı parolaları veya özel kamera adresleri bulunmaz. Yayın içerikleri ve kanal markaları ilgili hak sahiplerine aittir.

[Ürün sayfasına dön](../README.md)

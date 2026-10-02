# MP TV

## Son Surum: 2.0.2

[APK indir ve surum notlarini oku](https://github.com/neoxmp/mp-tv-releases/releases/latest).

2.0.2, 2.0.1'de eklenen VOD, ONVIF kesif, kumanda ve coklu izleme yeniliklerine ek olarak APK imza okuma uyumlulugunu duzeltir. **2.0.0/2.0.1'den ilk gecis icin APK'yi bu sayfadan indirip mevcut uygulamanin uzerine kurun; uygulamayi kaldirmayin.** Android 9 ve 10 testlerinde eski surum dogru imzali guncellemeyi reddetti. 2.0.2'de imza ve dosya butunlugu kontrolleri korunur.

### Surum Dogrulamasi

- 80 otomatik test, release derlemesi ve Android lint kontrolu basarili.
- Android emulatorunde dort canli yayinla coklu izleme, bos siyah katmanlarin kaldirilmasi, her bolmede filigran ve kontrolleri gizleme/geri getirme kontrol edildi.
- Guncelleme duzeltmesi uygulanmis, surum kodu 21 olan test kurulumundan GitHub'daki 2.0.2'ye uygulama ici indirme, butunluk/imza dogrulama, Android kurulum izni ve gercek APK kurulumu tamamlandi; cihazda surum kodu 22 dogrulandi. Bu, hatali eski 2.0.0 APK'sindan otomatik guncellemenin calistigi anlamina gelmez; yukaridaki ilk gecis notu gecerlidir.
- ONVIF kesif ekrani ve taklit Media1 cihaz yanitlariyla profil/RTSP alisverisi denendi. Gercek kamera/NVR donanimi bulunmadigindan marka/model uyumlulugu henuz dogrulanmadi.

Android TV, televizyon kutusu ve Android cihazlar icin TV ve kamera izleyicisi. Kaynak kodu ozel depoda tutulur; bu depo urun belgelerini, herkese acik hazir listeleri ve uygulama surumlerinin dagitim alanini barindirir.

## Hazir Listeler

| Liste | Dogrudan M3U adresi |
| --- | --- |
| TV | [tv.m3u](https://raw.githubusercontent.com/neoxmp/mp-tv-releases/main/playlists/tv.m3u) |
| Public CCTV | [public-cctv.m3u](https://raw.githubusercontent.com/neoxmp/mp-tv-releases/main/playlists/public-cctv.m3u) |

MP TV 2.0.0 bu adresleri varsayilan liste kaynagi olarak kullanir. Internet yokken uygulamaya gomulu son liste kullanilir. Ayarlardan **hazir TV listesi**, **hazir Public CCTV listesi** ve **otomatik liste yenileme** birbirinden bagimsiz kapatilabilir. Kapatilan hazir listeler otomatik olarak tekrar acilmaz. Kendi eklediginiz kaynaklar korunur. Otomatik yenileme aciksa uygulama baslangicinda ve Android'in zamanladigi arka plan gorevlerinde listeler yenilenir; Android arka plan calisma zamanini garanti etmez. GitHub'daki listeyi degistirmek icin yeni APK gerekmez.

### Kamera Dogrulamasi

2 Ekim 2026 kontrolunde Public CCTV listesine yalnizca IBB'nin resmi turistik kamera sayfalarindan alinmis, HLS manifesti ve gercek video parcasi erisimi dogrulanmis alti yayin eklenmistir: Anadolu Hisari, Beyazit Kulesi 2, Beyazit Meydani, Buyuk Camlica, Dragos ve Eminonu.

Kaynak: [IBB Istanbul'u Seyret](https://istanbuluseyret.ibb.istanbul/tr/turistik-kameralar), [IBB kamera hizmeti](https://ibb.istanbul/tum-hizmetler/e-belediye-hizmetleri/e-bilgi/kameralar/).

**Bunlar trafik denetim kamerasi degil, kamuya acik sehir/turistik kameralardir.** Denenen IBB trafik video adreslerinde TLS hatasi veya baglanti zaman asimi goruldugu icin bu adresler aktif listeye alinmadi. KGM, valilik ve kaymakamlik adina dogrulanmamis yayin eklenmedi. Kimlik dogrulama, ozel ag veya erisim kisitlamasi asilmadi. Kamuya acik olmak yayinlari yeniden dagitma hakki vermez; goruntu ilgili kurumdan dogrudan alinir ve kurumun kullanim kosullari gecerlidir.

[Dogrulama kaydi](playlists/verification.json) kontrol zamanini, kaynak sayfasini ve ornek video parcasi sonucunu icerir. Bir anlik erisim kontrolu surekli yayin veya her cihazda codec uyumlulugu garantisi degildir. Sonradan degisen kaynaklar liste bakimi ile duzeltilir.

## TV ve IPTV

2.0.1'de **VOD** sekmesine URL veya yerel M3U dosyasindan film/video listesi eklenebilir; mevcut listeye ekleme veya degistirme secilir. VOD kaynaklari otomatik canli kanal saglik kontrolune dahil edilmez, bittiginde sonsuz tekrar oynatilmaz. Desteklenen HTTP(S) video/HLS kaynaklari kullanilir; DRM'li servis girisi veya Xtream film/dizi/sezon katalog arayuzu bu liste ozelliginin parcasi degildir.

- M3U listesini URL'den veya yerel dosyadan yukleme; mevcut listeye ekleme ya da listeyi degistirme.
- Xtream sunucu adresi, kullanici adi ve parola ile M3U/XMLTV baglantisi. Bu entegrasyon canli yayin icindir; VOD/dizi katalog yonetimi vaadi yoktur.
- XMLTV/EPG destegi; yayin rehberinin gorunmesi kanal kimliklerinin kaynakla eslesmesine ve rehberin guncel olmasina baglidir.
- Kanal arama, ad degistirme, siralama, gizleme ve gizlenen kanallari geri getirme.
- Farkli listelerden ortak favorilere kaynak ekleme.
- Kanal saglik kontrolu ve oynatma hatalarinda sinirli yeniden deneme.

TV listesi iptv-org listesindeki kamuya acik adreslerden kontrol edilebilen bir alt kume olarak hazirlanmistir; tum Turkiye kanallarinin listesi degildir. Kaynak: [iptv-org/iptv](https://github.com/iptv-org/iptv). Listeye EPG adresi eklenmesi her kanal icin eslesme garantisi vermez.

## Kameralar ve NVR

- TV, Public CCTV, CCTV ve kullanicinin adlandirdigi kaynak listeleri.
- RTSP, HTTP veya HTTPS video kaynagi ekleme; RTSP icin hesap bilgisi girme.
- Kamera icin ayri main ve sub stream adresleri; tekli izleme ve bolunmus goruntude akis secimi.
- Yerel agda ONVIF kamera/NVR kesfi, IP veya ONVIF servis adresi ile baglanti, H.264 profil secimi ve main/sub RTSP adreslerini alma (2.0.1).
- NVR cihazinin erisilebilir, desteklenen RTSP yayinini goruntuleme. NVR yonetimi, kayit arsivi ve PTZ kontrolu bu surumun ozellikleri degildir.
- Kamera, TV ve farkli listelerden secilen yayinlari birlikte goruntuleme.

RTSP oynatma Media3 uzerinden TCP kullanir. Kamera/NVR cihazinda RTSP yayini etkin olmali, cihaz agdan erisilebilir olmali ve codec desteklenmelidir. Ozellikle H.265 RTSP uyumlulugu varsayilmamalidir; H.264 ve uygun sub stream kullanin. [Media3 RTSP belgeleri](https://developer.android.com/media/media3/exoplayer/rtsp).

## Coklu Goruntu

2.0.1'de **Kontrolleri gizle** tum bolumleri koruyarak ust menu ve bolum basliklarini gizler. Geri/Menu tusu veya kucuk gorunum dugmesi kontrolleri geri getirir. Her bolumde MP TV / Mustafa POLAT filigrani gorunur; yayin hazirken bos durum katmani tamamen kaldirilir.

1-32 goruntu hucresi, sutun sayisi ve ayni anda aktif yayin siniri ayarlanabilir. Hucre sayisi 32 olsa bile 32 akisin ayni anda sorunsuz oynatilmasi garanti edilmez. Uygulama bellek sinifi ve bildirilen H.264 decoder kapasitesine gore muhafazakar bir oneri sunar. Dortun veya onerilen sayinin uzerinde uyarir; kamera sub stream'lerini tercih eder. Aktif yayin siniri asildiginda eski bir goruntunun baglantisi kapatilir. Ses tek secili hucreden alinabilir; bir hucre tam ekrana alinabilir.

## Surum Guncellemesi

Uygulamadaki guncelleme ekrani bu deponun GitHub Releases alanini kontrol eder. Yayimlanan surumde APK ve update.json birlikte bulunmalidir. Uygulama paket kimligini, surumunu, boyutunu, SHA-256 ozetini ve imzasini kontrol eder. Kurulum Android'in onayi ile yapilir; sessiz kurulum yoktur. Yeni surumler ayni imzalama anahtari ile hazirlanmalidir. Hazir liste guncellemesi ile APK guncellemesi ayri islemlerdir.

[Yayimlanan surumler](https://github.com/neoxmp/mp-tv-releases/releases).

## Kumanda (2.0.1)

OK izleme menusunu acar. Menu acikken yon tuslari secenekler arasinda gezinir; OK odaktaki Kanallar/Ayarlar/Program/Coklu secenegini acar. Ses +, ses - ve mute Android yayin sesini yonetir; sag/sol artik sesi degistirmez. Yukari/asagi veya CH+/CH- normal izleme ekraninda kanal degistirir. INFO kanal bilgisini, GUIDE program rehberini acar. Medya oynat/duraklat tuslari ve ekrandaki Duraklat/Oynat dugmesi kullanilabilir. Ileri/geri sarma sarilabilir yayinlarda 10 saniyelik adimlarla calisir. Canli yayinda pause DVR garantisi vermez; uzun duraklamadan sonra guncel yayina donulebilir.

## Yerel ONVIF (2.0.1)

Kaynaklar ekranindan **Yerel kamera/NVR bul** secilir. Tarama yaklasik sekiz saniye surer. Cihaz secilip ONVIF hesabi girilir; main ve istege bagli sub profil secilerek aktif kaynak listesine eklenir. NVR'de profil adlari/kimlikleri farkli kanallari gosterebilir; main/sub icin ayni kameranin profillerini secin. Kesif yaniti gelmiyorsa IP:port veya tam HTTP(S) ONVIF servis adresi girilebilir. Cihazda ONVIF etkin, hesap yetkili ve RTSP/H.264 kullanilabilir olmalidir. Farkli VLAN, misafir Wi-Fi izolasyonu, VPN, emulator NAT'i veya multicast engeli otomatik kesfi onleyebilir. Cihaz saati WS-Security dogrulamasi icin dogru olmalidir. Her marka/firmware icin uyumluluk iddiasi yoktur; gercek NVR ile saha dogrulamasi ayridir.

## Gizlilik ve Sinirlar

Bu depo kullanici hesaplari, ozel kamera adresleri veya erisim anahtarlari icermez. Kisisel kaynaklarinizi bu herkese acik depoya eklemeyin. Hazir listeler icin GitHub'a, goruntu icin ilgili yayin sunucusuna baglanilir. Yalnizca erisim izniniz olan yayinlari kullanin. Uygulama yayin saglayici, kayit sistemi veya guvenlik alarm sistemi degildir.

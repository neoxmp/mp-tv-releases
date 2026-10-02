# MP TV

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
- NVR cihazinin erisilebilir, desteklenen RTSP yayinini goruntuleme. NVR yonetimi, kayit arsivi, PTZ kontrolu ve ONVIF kesfi bu surumun ozellikleri degildir.
- Kamera, TV ve farkli listelerden secilen yayinlari birlikte goruntuleme.

RTSP oynatma Media3 uzerinden TCP kullanir. Kamera/NVR cihazinda RTSP yayini etkin olmali, cihaz agdan erisilebilir olmali ve codec desteklenmelidir. Ozellikle H.265 RTSP uyumlulugu varsayilmamalidir; H.264 ve uygun sub stream kullanin. [Media3 RTSP belgeleri](https://developer.android.com/media/media3/exoplayer/rtsp).

## Coklu Goruntu

1-32 goruntu hucresi, sutun sayisi ve ayni anda aktif yayin siniri ayarlanabilir. Hucre sayisi 32 olsa bile 32 akisin ayni anda sorunsuz oynatilmasi garanti edilmez. Uygulama bellek sinifi ve bildirilen H.264 decoder kapasitesine gore muhafazakar bir oneri sunar. Dortun veya onerilen sayinin uzerinde uyarir; kamera sub stream'lerini tercih eder. Aktif yayin siniri asildiginda eski bir goruntunun baglantisi kapatilir. Ses tek secili hucreden alinabilir; bir hucre tam ekrana alinabilir.

## Surum Guncellemesi

Uygulamadaki guncelleme ekrani bu deponun GitHub Releases alanini kontrol eder. Yayimlanan surumde APK ve update.json birlikte bulunmalidir. Uygulama paket kimligini, surumunu, boyutunu, SHA-256 ozetini ve imzasini kontrol eder. Kurulum Android'in onayi ile yapilir; sessiz kurulum yoktur. Yeni surumler ayni imzalama anahtari ile hazirlanmalidir. Hazir liste guncellemesi ile APK guncellemesi ayri islemlerdir.

[Yayimlanan surumler](https://github.com/neoxmp/mp-tv-releases/releases).

## Gizlilik ve Sinirlar

Bu depo kullanici hesaplari, ozel kamera adresleri veya erisim anahtarlari icermez. Kisisel kaynaklarinizi bu herkese acik depoya eklemeyin. Hazir listeler icin GitHub'a, goruntu icin ilgili yayin sunucusuna baglanilir. Yalnizca erisim izniniz olan yayinlari kullanin. Uygulama yayin saglayici, kayit sistemi veya guvenlik alarm sistemi degildir.

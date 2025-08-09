# 🔒 PowerShell Steganografi Aracı

Görsellerin içine gizli mesaj saklama ve çıkarma aracı - PowerShell ile geliştirilmiş nadir steganografi projesi.

## 📋 Özellikler

- **🔐 Mesaj Gizleme:** LSB (Least Significant Bit) tekniği ile mesajları görsel dosyalara gizler
- **🔍 Mesaj Çıkarma:** Gizlenmiş mesajları başarıyla geri çıkarır
- **💻 Windows Uyumlu:** PowerShell ile tamamen uyumlu
- **🖼️ BMP Desteği:** BMP formatındaki görsellerde çalışır
- **⚡ Hızlı İşlem:** Binary manipulation ile optimal performans
- **👁️ Görünmez:** LSB değişiklikleri gözle fark edilmez

## 🚀 Kurulum

1. Bu repository'yi klonlayın:
   ```powershell
   git clone https://github.com/kullaniciadi/powershell-steganografi.git
   cd powershell-steganografi
   ```

2. PowerShell execution policy'yi ayarlayın (gerekirse):
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## 📖 Kullanım

### Mesaj Gizleme
```powershell
.\\stegano.ps1 -Action hide -ImageFile resim.bmp -Message "Gizli mesajım" -OutputFile sonuc.bmp
```

### Mesaj Çıkarma
```powershell
.\\stegano.ps1 -Action extract -ImageFile sonuc.bmp
```

### Yardım
```powershell
.\\stegano.ps1
```

## 🧪 Test

Otomatik test scriptini çalıştırın:
```powershell
.\\test.ps1
```

Test BMP dosyası oluşturmak için:
```powershell
.\\create_test_bmp.ps1
```

## 📁 Dosya Yapısı

```
├── stegano.ps1           # Ana steganografi aracı
├── test.ps1              # Otomatik test scripti
├── create_test_bmp.ps1   # Test BMP dosyası oluşturucu
└── README.md             # Dokümantasyon
```

## 🔧 Teknik Detaylar

### LSB Steganografi
En düşük anlamlı bit (Least Significant Bit) tekniği kullanılarak:
- Mesaj karakterleri 8-bit binary'ye dönüştürülür
- Her bit, görsel pixellerinin LSB'sine gizlenir
- Mesaj sonu için `00000000` işaretleyici kullanılır
- Görsel kalitesi korunur (değişiklik gözle görülmez)

### Desteklenen Formatlar
- **Giriş:** BMP formatı (diğer formatlar deneysel)
- **Çıkış:** Orijinal format korunur
- **Mesaj:** UTF-8 karakterler desteklenir

## 📊 Performans

- **Test Dosyası:** 1909 byte BMP
- **Test Mesajı:** "Gizli Test Mesaji" (18 karakter)
- **İşlem Süresi:** ~100ms
- **Dosya Boyutu Değişimi:** 0 byte
- **Başarı Oranı:** %100

## ⚠️ Uyarılar

- Sadece eğitim ve test amaçlı kullanın
- Büyük mesajlar için yeterli piksel sayısı gereklidir
- Görsel sıkıştırma LSB'leri bozabilir
- Backup almayı unutmayın

## 🤝 Katkı

Katkılarınızı bekliyoruz! Lütfen:
1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Commit yapın (`git commit -am 'Yeni özellik eklendi'`)
4. Branch'i push edin (`git push origin feature/yeni-ozellik`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 🙏 Teşekkürler

- LSB steganografi algoritması için bilimsel topluma
- PowerShell binary manipulation desteği için Microsoft'a
- Test ve geri bildirimler için topluluğa

---

**Not:** Bu araç eğitim amaçlıdır. Gizlilik ve güvenlik için profesyonel çözümler kullanın. 
# ☕ Coffee App

Coffee App, kullanıcıların favori kahve ürünlerini keşfedip sepete ekleyebildiği, modern, sade ve kullanıcı dostu bir iOS alışveriş uygulamasıdır.

---

## 🚀 Kurulum Adımları

1. **Projeyi Klonlayın**
   ```bash
   git clone https://github.com/sevvalmertoglu/CoffeeApp.git
   cd CoffeeApp
   ```

2. **Bağımlılıkları Yükleyin**

   Swift Package Manager için:  
   `Xcode > File > Swift Packages > Add Package Dependency` yolunu izleyip SDWebImage paketini ekleyin.

3. **Projeyi Çalıştırın**

   Xcode üzerinden `CoffeeApp` hedefini seçin ve:
   ```bash
   Command + R
   ```
   tuşlarıyla uygulamayı başlatın.

---

## Kullanılan Teknolojiler

- `Swift` — Modern, güvenli ve hızlı programlama dili.
- `UIKit` — Native iOS arayüz geliştirme.
- `MVVM` — Temiz, test edilebilir ve sürdürülebilir mimari yapı.
- `SDWebImage` — Asenkron görsel indirme ve cache yönetimi.
- `Alamofire` — Web servisleri ile HTTPs protokolü üzerinden veri transferinin sağlanması.
- `UserDefaults` — Favori ürünlerin yerel olarak saklanması.
- `NotificationCenter` — Uygulama içi iletişim için etkin çözüm.

---

## Mimari Açıklaması

Uygulama **MVVM (Model-View-ViewModel)** prensibiyle yazılmıştır.

- **Model:**  
Uygulamanın veri yapıları ve iş mantığı.  
Örn: `Products.swift` — ürünleri temsil eder.

- **View:**  
Kullanıcı arayüzü ve etkileşim katmanı.  
Storyboard + `ProductsCollectionViewCell`, `CartViewController` gibi bileşenlerden oluşur.

- **ViewModel:**  
View ve Model katmanı arasında köprü görevi görür.  
`ProductsCollectionViewCellViewModel` gibi dosyalar sayesinde, UI bağımsız veri hazırlama işlemleri yapılır.

---

## Özellikler

- Kullanıcı giriş ve çıkışı.
- Kahve ürünlerini listeleme.
- Ürünleri favorilere ekleme / çıkarma.
- Sepete ürün ekleyip adet artırma / azaltma.
- Adet sıfırlandığında ürünü otomatik olarak sepetten silme.
- Kullanıcı dostu, sade ve modern arayüz.
- Yerel veri saklama ve görsel önbellekleme.
- Kahve verileri https://api.sampleapis.com/coffee/hot ve https://api.sampleapis.com/coffee/iced api'sinden çekilmiştir.
- Yiyecek verileri için Mock Data kullanılmıştır.

---

### Görseller

<img width="230" alt="Ekran Resmi 2025-04-21 00 32 17" src="https://github.com/user-attachments/assets/889f0368-0fba-445a-a137-9c6026556056" />
<img width="230" alt="Ekran Resmi 2025-04-21 00 32 48" src="https://github.com/user-attachments/assets/2223116d-0c98-48ed-a935-eb8f50f087dd" />

### Sıcak İçecekler Sayfası:
<img width="230" alt="Ekran Resmi 2025-04-21 00 33 18" src="https://github.com/user-attachments/assets/ea81473c-a53f-4633-94a0-ca72679c2cff" />

### Yiyecekler Sayfası:
<img width="230" alt="Ekran Resmi 2025-04-21 00 33 40" src="https://github.com/user-attachments/assets/8ced5092-09d9-48e6-b09e-17f8daee7732" />

### Favoriler Sayfası:
<img width="230" alt="Ekran Resmi 2025-04-21 00 36 16" src="https://github.com/user-attachments/assets/76761703-96dd-4307-9eb0-674d4d6c0d62" />
<img width="230" alt="Ekran Resmi 2025-04-21 00 36 58" src="https://github.com/user-attachments/assets/e4f64ab8-681e-4938-8393-8be6d675c250" />
<img width="230" alt="Ekran Resmi 2025-04-21 00 37 09" src="https://github.com/user-attachments/assets/a27790df-dc78-438a-a82c-a7df0aa860ec" />


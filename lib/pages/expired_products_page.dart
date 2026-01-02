import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:dolaptakip/widgets/expired_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

// ExpiredProductsPage: Sadece "Süresi Dolmuş" veya "Bugün Son" olan ürünleri gösteren sayfa.
class ExpiredProductsPage extends StatelessWidget {
  const ExpiredProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer: FridgeProvider'ı dinleyerek veri değiştiğinde sayfayı yeniler.
    return Consumer<FridgeProvider>(
      builder: (context, provider, child) {
        final l10n = AppLocalizations.of(context)!;

        // --- Filtreleme Mantığı ---
        // Tüm ürünler listesinden (provider.items) sadece SKT'si geçmiş olanları çekiyoruz.
        final expiredItems = provider.items.where((item) {
          final now = DateTime.now();
          final today = DateTime(
            now.year,
            now.month,
            now.day,
          ); // Bugünün tarihi (saatsiz).
          // Eğer son kullanma tarihi bugünden önceyse, ürün bozulmuştur.
          return item.expirationDate.isBefore(today);
        }).toList();

        // --- Sıralama Mantığı ---
        // En eski tarihli ürün en üstte görünsün.
        expiredItems.sort(
          (a, b) => a.expirationDate.compareTo(b.expirationDate),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.expiredPageTitle), // Localized Title
            // Geri dön butonu
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Liste boş ise "Süresi geçen ürün yok" mesajı görünür.
          body: expiredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Colors.green.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.emptyExpiredMessage, // Localized Empty Message
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // --- Üst Bilgi Kartı (Header) ---
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          // Hafif gölgelendirme
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(20),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Kırmızı Ünlem İkonu
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFEBEE), // Çok açık kırmızı
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.priority_high_rounded,
                                color: Color(0xFFFF3B30),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Yazılı İçerik
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.attentionTitle, // Localized
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // RichText: Tek satırda farklı stillerde yazı yazmak için kullanılır.
                                  // Simplified logic for localization since RichText is hard to split
                                  Text(
                                    l10n.totalExpiredItems(
                                      expiredItems.length,
                                    ), // Localized with param
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- Alt Başlık ---
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.detectedTitle, // Localized
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              l10n.urgentLabel, // Localized
                              style: const TextStyle(
                                color: Color(0xFFFF3B30),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- Liste ---
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          120, // Alt buton için padding.
                        ),
                        itemCount: expiredItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = expiredItems[index];
                          // Her satırda ExpiredListItem kullanıyoruz.
                          return ExpiredListItem(item: item);
                        },
                      ),
                    ),
                  ],
                ),

          // --- Alt Buton (Tümünü Temizle) ---
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat, // Butonu ortala
          floatingActionButton: expiredItems.isEmpty
              ? null // Liste boşsa butonu gizle.
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom:
                        110, // Bottom Navigation Bar'ın üzerine denk gelmemesi için pay.
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Tüm süresi geçen ürünleri döngüyle sil.
                        for (var item in expiredItems) {
                          provider.removeItem(item.id);
                        }

                        // Kullanıcıya bilgi ver (SnackBar).
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l10n.clearAllSuccess, // Localized
                            ),
                            backgroundColor: const Color(0xFFFF3B30),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3B30),
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: const Color(0xFFFF3B30).withAlpha(100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.delete_sweep_rounded),
                      label: Text(
                        l10n.clearAllButton, // Localized
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

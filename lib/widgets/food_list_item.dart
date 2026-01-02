import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

// FoodListItem: Ana sayfada listelenen her bir yiyecek kartının tasarımıdır.
class FoodListItem extends StatelessWidget {
  final FoodItem item; // Görüntülenecek yiyecek verisi.

  const FoodListItem({super.key, required this.item});

  String _getStatusText(BuildContext context, int days) {
    var l10n = AppLocalizations.of(context)!;
    if (days < 0) return l10n.expiredStatus;
    // daysLeft plural in ARB handles 0 (Today), 1 (Tomorrow), and other (X days left)
    return l10n.daysLeft(days);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // --- Sol Taraf: Yiyecek Resmi ---
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: item.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    )
                  : const Center(
                      child: Text('🍎', style: TextStyle(fontSize: 32)),
                    ),
            ),
            const SizedBox(width: 16),
            // --- Orta Kısım: Yazılar ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Durum Kartı (Örn: "3 gün kaldı")
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: item.statusColor.withAlpha(50)),
                    ),
                    child: Text(
                      _getStatusText(context, item.daysLeft), // Localized Logic
                      style: TextStyle(
                        color: item.statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Sağ Taraf: Silme Butonu ---
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: Colors.grey,
              onPressed: () {
                Provider.of<FridgeProvider>(
                  context,
                  listen: false,
                ).removeItem(item.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

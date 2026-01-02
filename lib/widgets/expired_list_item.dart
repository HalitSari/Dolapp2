import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

// ExpiredListItem: "Süresi Geçenler" sayfasındaki riskli ürünlerin kart tasarımı.
class ExpiredListItem extends StatelessWidget {
  final FoodItem item;

  const ExpiredListItem({super.key, required this.item});

  String _getTimeAgo(BuildContext context, int days) {
    var l10n = AppLocalizations.of(context)!;
    if (days == 0) return l10n.timeAgoToday;
    if (days == -1) return l10n.timeAgoYesterday;
    if (days < -1) return l10n.timeAgoPast(days.abs());
    return '';
  }

  String _getExpiredStatusText(BuildContext context, int days) {
    var l10n = AppLocalizations.of(context)!;
    if (days < -7) return l10n.expiredWarningUrgent;
    if (days < -3) return l10n.expiredWarningRisk;
    return l10n.expiredWarningPast;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Sol taraftaki kırmızı dikey şerit (Vurgu)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: const Color(0xFFFF3B30).withAlpha(100)),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  // --- Ürün Resmi ---
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: item.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.kitchen, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),

                  // --- Bilgiler ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                            // Ne zaman bozuldu? (Örn: "Dün")
                            Text(
                              _getTimeAgo(context, item.daysLeft), // Localized
                              style: const TextStyle(
                                color: Color(0xFFFF3B30),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Kategori Bilgisi
                        Text(
                          item.category, // Technically should be localized too via map if possible
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Uyarı Durumu (Örn: "Bozulmuş olabilir", "ACİL")
                        Row(
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              size: 14,
                              color: Color(0xFFFF3B30),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getExpiredStatusText(
                                context,
                                item.daysLeft,
                              ), // Localized
                              style: const TextStyle(
                                color: Color(0xFFFF3B30),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (item.isUrgent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  l10n.urgentLabel, // Localized
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // --- Silme Butonu ---
                  IconButton(
                    onPressed: () {
                      Provider.of<FridgeProvider>(
                        context,
                        listen: false,
                      ).removeItem(item.id);
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

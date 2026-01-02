import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:dolaptakip/widgets/expired_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpiredProductsPage extends StatelessWidget {
  const ExpiredProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FridgeProvider>(
      builder: (context, provider, child) {
        // Filter for expired items: expirationDate is before now (ignoring time if needed, but simple comparison works for now)
        final expiredItems = provider.items.where((item) {
          // Assuming expirationDate includes time 00:00:00, comparing to now might show today's items as expired if now > 00:00.
          // Let's say an item expires at the END of the day.
          // So we should compare if expirationDate is before today (start of today).
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          // If expiration is strictly before today, it is expired.
          return item.expirationDate.isBefore(today);
        }).toList();

        // Sort by expiration date descending (most expired first)
        expiredItems.sort(
          (a, b) => a.expirationDate.compareTo(b.expirationDate),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Süresi Geçenler'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
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
                      const Text(
                        "Süresi geçen ürün yok!",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Header Alert Card
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
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
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFEBEE), // Very light red
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.priority_high_rounded,
                                color: Color(0xFFFF3B30),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dikkat Gerekenler',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Toplam '),
                                        TextSpan(
                                          text: '${expiredItems.length} ürünün',
                                          style: const TextStyle(
                                            color: Color(0xFFFF3B30),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text:
                                              ' son tüketim tarihi geçmiş durumda.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Sub-header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TESPİT EDİLENLER',
                            style: TextStyle(
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
                            child: const Text(
                              'ACİL',
                              style: TextStyle(
                                color: Color(0xFFFF3B30),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          120,
                        ), // Increased bottom padding to avoid button overlap
                        itemCount: expiredItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = expiredItems[index];
                          return ExpiredListItem(item: item);
                        },
                      ),
                    ),
                  ],
                ),
          // Bottom Button
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: expiredItems.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 110, // Increased to clearly clear the bottom nav
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Clear all expired items
                        for (var item in expiredItems) {
                          provider.removeItem(item.id);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Tüm süresi geçen ürünler temizlendi!',
                            ),
                            backgroundColor: Color(0xFFFF3B30),
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
                      label: const Text(
                        'Tümünü Temizle',
                        style: TextStyle(
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

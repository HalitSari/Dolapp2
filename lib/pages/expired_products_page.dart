import 'package:flutter/material.dart';

class ExpiredProductsPage extends StatefulWidget {
  const ExpiredProductsPage({super.key});

  @override
  State<ExpiredProductsPage> createState() => _ExpiredProductsPageState();
}

class _ExpiredProductsPageState extends State<ExpiredProductsPage> {
  // Mock data moved to state to enable modification
  final List<Map<String, dynamic>> _expiredItems = [
    {
      'name': 'Tam Yağlı Süt',
      'brand': 'Sütaş • 1 Litre',
      'status': 'Tüketim tarihi geçti',
      'time': 'Dün',
      'urgent': false,
      'image': 'assets/images/milk_bottle.png',
    },
    {
      'name': 'Süzme Yoğurt',
      'brand': 'Sek • 500g',
      'status': 'Riskli olabilir',
      'time': '2 gün önce',
      'urgent': false,
      'image': 'assets/images/yogurt_bowl.png',
    },
    {
      'name': 'Domates',
      'brand': 'Manav • 1 kg',
      'status': 'Bozulmuş olabilir',
      'time': '1 hafta önce',
      'urgent': false,
      'image': 'assets/images/tomatoes.png',
    },
    {
      'name': 'Cheddar Peyniri',
      'brand': 'Pınar • 200g',
      'status': 'Derhal atın',
      'time': '12 gün önce',
      'urgent': true,
      'image': 'assets/images/cheddar_cheese.png',
    },
  ];

  void _removeItem(int index) {
    setState(() {
      _expiredItems.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _expiredItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Süresi Geçenler'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _expiredItems.isEmpty
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE), // Very light red
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
                                      text: '${_expiredItems.length} ürünün',
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
                        'BUGÜN TESPİT EDİLENLER',
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
                    itemCount: _expiredItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = _expiredItems[index];
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
                              // Left accent border
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                width: 4,
                                child: Container(
                                  color: const Color(0xFFFF3B30).withAlpha(100),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ), // Spacing for border
                                    // Image
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: AssetImage(item['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFF2D3436),
                                                ),
                                              ),
                                              Text(
                                                item['time'],
                                                style: const TextStyle(
                                                  color: Color(
                                                    0xFFFF3B30,
                                                  ), // Red text for date
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item['brand'],
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.warning_amber_rounded,
                                                size: 14,
                                                color: Color(0xFFFF3B30),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                item['status'],
                                                style: const TextStyle(
                                                  color: Color(0xFFFF3B30),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      // Made interactive
                                      onPressed: () => _removeItem(index),
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
                    },
                  ),
                ),
              ],
            ),
      // Bottom Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _expiredItems.isEmpty
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
                    _clearAll();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tüm süresi geçen ürünler temizlendi!'),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
    );
  }
}

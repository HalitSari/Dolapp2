import 'package:dolaptakip/pages/expired_products_page.dart';
import 'package:dolaptakip/pages/recipes_page.dart';
import 'package:dolaptakip/widgets/add_item_sheet.dart';
import 'package:dolaptakip/widgets/custom_bottom_nav.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dolaptakip/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(), // Extracting Home Content to separate widget for cleanliness
    const ExpiredProductsPage(),
    const RecipesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showAddItemSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddItemSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Content behind floating nav
      appBar: AppBar(
        title: const Text('Dolabım'),
        centerTitle: false,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _showAddItemSheet,
              child: const Icon(Icons.add_rounded, size: 32),
            )
          : null,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Color _getStatusColor(int daysLeft) {
    if (daysLeft <= 0) return const Color(0xFFFF5252); // Red
    if (daysLeft <= 2) return const Color(0xFFFFAB40); // Orange
    if (daysLeft <= 5) return const Color(0xFFFFD740); // Amber
    return const Color(0xFF00E676); // Green/Mint
  }

  String _getStatusText(int daysLeft) {
    if (daysLeft < 0) return 'Süresi Doldu';
    if (daysLeft == 0) return 'Bugün Son';
    if (daysLeft == 1) return 'Yarın Son';
    return '$daysLeft gün kaldı';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FridgeProvider>(
      builder: (context, provider, child) {
        final items = provider.items;

        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.kitchen_rounded,
                  size: 80,
                  color: Colors.grey.withAlpha(50),
                ),
                const SizedBox(height: 24),
                Text(
                  'Dolabın boş görünüyor.\nHemen bir şeyler ekle!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            100,
          ), // Bottom padding for FAB/Nav
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            final daysLeft =
                item.expirationDate.difference(DateTime.now()).inDays + 1;
            final statusColor = _getStatusColor(daysLeft);

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
                    // Image Container
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
                    // Content
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: statusColor.withAlpha(50),
                              ),
                            ),
                            child: Text(
                              _getStatusText(daysLeft),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: Colors.grey,
                      onPressed: () => provider.removeItem(item.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:dolaptakip/pages/expired_products_page.dart';
import 'package:dolaptakip/pages/recipes_page.dart';
import 'package:dolaptakip/widgets/add_item_sheet.dart';
import 'package:dolaptakip/widgets/custom_bottom_nav.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dolaptakip/widgets/food_list_item.dart';
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
            return FoodListItem(item: item);
          },
        );
      },
    );
  }
}

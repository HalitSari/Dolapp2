import 'package:dolaptakip/pages/expired_products_page.dart';
import 'package:dolaptakip/pages/recipes_page.dart';
import 'package:dolaptakip/widgets/add_item_sheet.dart';
import 'package:dolaptakip/widgets/custom_bottom_nav.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(title: const Text('Dolabım')),
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _showAddItemSheet,
              child: const Icon(Icons.add),
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
    if (daysLeft <= 0) return Colors.red.shade900;
    if (daysLeft <= 1) return Colors.red;
    if (daysLeft <= 2) return Colors.orange;
    if (daysLeft <= 3) return Colors.amber;
    return const Color(0xFF2C2C2C); // Default dark card color
  }

  Color _getTextColor(int daysLeft) {
    if (daysLeft <= 3) return Colors.black87;
    return Colors.white;
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
                Icon(Icons.kitchen, size: 64, color: Colors.grey[700]),
                const SizedBox(height: 16),
                Text(
                  'Dolabın boş görünüyor.\nHemen bir şeyler ekle!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final daysLeft =
                item.expirationDate.difference(DateTime.now()).inDays + 1;

            final cardColor = _getStatusColor(daysLeft);
            final textColor = _getTextColor(daysLeft);
            final subTextColor = daysLeft <= 3 ? Colors.black54 : Colors.grey;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: item.imageUrl != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(item.imageUrl!),
                        radius: 24,
                      )
                    : const Text(
                        '🍎',
                        style: TextStyle(fontSize: 32),
                      ), // Fallback emoji
                title: Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
                subtitle: Text(
                  daysLeft < 0
                      ? 'SKT Geçti (${-daysLeft} gün)'
                      : 'SKT: $daysLeft gün kaldı',
                  style: TextStyle(
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline, color: subTextColor),
                  onPressed: () {
                    provider.removeItem(item.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class ExpiredProductsPage extends StatelessWidget {
  const ExpiredProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for now
    final List<String> expiredItems = []; // Empty for now

    if (expiredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Tebrikler! SKT\'si geçen ürününüz yok.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: expiredItems.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withAlpha(153),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(color: Colors.red, width: 2),
          ),
          child: ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(
              expiredItems[index],
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'SKT Geçmiş!',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      },
    );
  }
}

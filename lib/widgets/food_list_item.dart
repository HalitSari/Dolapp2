import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodListItem extends StatelessWidget {
  final FoodItem item;

  const FoodListItem({super.key, required this.item});

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
                      color: item.statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: item.statusColor.withAlpha(50)),
                    ),
                    child: Text(
                      item.statusText,
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
            // Action
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

import 'package:dolaptakip/models/food_item.dart';
import 'package:flutter/material.dart';

class FridgeProvider extends ChangeNotifier {
  final List<FoodItem> _items = [];

  List<FoodItem> get items => List.unmodifiable(_items);

  void addItem(FoodItem item) {
    _items.add(item);
    // Sort items by expiration date (closest first)
    _items.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

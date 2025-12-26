import 'dart:convert';
import 'package:dolaptakip/models/food_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FridgeProvider extends ChangeNotifier {
  List<FoodItem> _items = [];

  List<FoodItem> get items => List.unmodifiable(_items);

  FridgeProvider() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsJson = prefs.getString('food_items');
    if (itemsJson != null) {
      final List<dynamic> decodedList = jsonDecode(itemsJson);
      _items = decodedList.map((item) => FoodItem.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('food_items', encodedList);
  }

  void addItem(FoodItem item) {
    _items.add(item);
    // Sort items by expiration date (closest first)
    _items.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
    _saveItems();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _saveItems();
    notifyListeners();
  }
}

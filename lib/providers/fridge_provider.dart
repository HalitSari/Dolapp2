import 'dart:async';
import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/services/firestore_service.dart';
import 'package:flutter/material.dart';

class FridgeProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<FoodItem> _items = [];
  StreamSubscription<List<FoodItem>>? _itemsSubscription;

  List<FoodItem> get items => List.unmodifiable(_items);

  FridgeProvider() {
    _init();
  }

  void _init() {
    _itemsSubscription = _firestoreService.getItems().listen((items) {
      _items = items;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _itemsSubscription?.cancel();
    super.dispose();
  }

  Future<void> addItem(FoodItem item) async {
    await _firestoreService.addItem(item);
  }

  Future<void> removeItem(String id) async {
    await _firestoreService.removeItem(id);
  }
}

import 'dart:async';
import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/services/firestore_service.dart';
import 'package:flutter/material.dart';

class FridgeProvider extends ChangeNotifier {
  // Oluşturduğumuz servisi burada kullanıyoruz.
  final FirestoreService _firestoreService = FirestoreService();

  // Ekranda gösterilecek liste. Eskiden bunu SharedPreferences'tan dolduruyorduk.
  List<FoodItem> _items = [];

  // Stream aboneliği (Subscription). Musluğu açtık, suyun akışını kontrol ediyoruz.
  // Uygulama kapanınca musluğu kapatmak (cancel) bellek sızıntısını önler.
  StreamSubscription<List<FoodItem>>? _itemsSubscription;

  List<FoodItem> get items => List.unmodifiable(_items);

  FridgeProvider() {
    _init(); // Provider oluştuğunda dinlemeyi başlat.
  }

  void _init() {
    // Servisteki akışı dinlemeye başlıyoruz/abone oluyoruz (.listen).
    _itemsSubscription = _firestoreService.getItems().listen((items) {
      _items =
          items; // Veritabanından her yeni liste geldiğinde içerdeki listeyi güncelle.
      notifyListeners(); // Arayüze (UI) "Veri değişti, ekranı yenile!" diye bağır.
    });
  }

  @override
  void dispose() {
    // Provider bellekten silinirse (bu uygulama için pek olası değil ama iyi alışkanlık)
    // aboneliği iptal et.
    _itemsSubscription?.cancel();
    super.dispose();
  }

  // Ekleme ve silme işlemleri artık yerel listeye değil, direkt servise gidiyor.
  // Servis veritabanını güncelleyince, yukarıdaki "listen" metodu tetiklenip ekranı otomatik güncelleyecek.
  Future<void> addItem(FoodItem item) async {
    await _firestoreService.addItem(item);
  }

  Future<void> removeItem(String id) async {
    await _firestoreService.removeItem(id);
  }
}

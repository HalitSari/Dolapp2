import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolaptakip/models/food_item.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  // Stream of items
  Stream<List<FoodItem>> getItems() {
    return _itemsCollection
        .orderBy('expirationDate', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return FoodItem.fromFirestore(doc, null);
          }).toList();
        });
  }

  // Add Item
  Future<void> addItem(FoodItem item) async {
    // We use the item's ID as the document ID
    await _itemsCollection.doc(item.id).set(item.toFirestore());
  }

  // Remove Item
  Future<void> removeItem(String id) async {
    await _itemsCollection.doc(id).delete();
  }
}

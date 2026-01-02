import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolaptakip/models/food_item.dart';

class FirestoreService {
  // 'items' adında bir koleksiyona referans (bağlantı noktası) oluşturuyoruz.
  // Eğer veritabanında bu isimde bir tablo yoksa, ilk veri eklendiğinde otomatik oluşur.
  final CollectionReference<Map<String, dynamic>> _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  // Verileri anlık takip etmek (Listen) için bir "Stream" (Akış) oluşturuyoruz.
  // Stream: Veri her değiştiğinde (ekleme/silme/güncelleme) bize yeni listeyi gönderen bir boru hattı gibidir.
  Stream<List<FoodItem>> getItems() {
    return _itemsCollection
        .orderBy(
          'expirationDate',
          descending: false,
        ) // SKT'ye göre eskiden yeniye sırala.
        .snapshots() // Veritabanının anlık görüntüsünü (snapshot) sürekli dinle.
        .map((snapshot) {
          // Gelen snapshot içindeki dökümanları (docs) tek tek gezip FoodItem'a çeviriyoruz.
          return snapshot.docs.map((doc) {
            return FoodItem.fromFirestore(
              doc,
              null,
            ); // Modeldeki dönüşüm metodunu kullandık.
          }).toList();
        });
  }

  // Veri Ekleme / Güncelleme
  // "Future": İşlemin sonucunu ilerde döneceğini belirtir (Asenkron işlem).
  Future<void> addItem(FoodItem item) async {
    // .doc(item.id): Belirtilen ID ile bir döküman seçer.
    // .set(...): O dökümanın içeriğini belirler. Eğer varsa günceller, yoksa oluşturur.
    await _itemsCollection.doc(item.id).set(item.toFirestore());
  }

  // Veri Silme
  Future<void> removeItem(String id) async {
    // .doc(id).delete(): ID'si verilen dökümanı kalıcı olarak siler.
    await _itemsCollection.doc(id).delete();
  }
}

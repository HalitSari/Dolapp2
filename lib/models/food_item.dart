import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final DateTime expirationDate;
  final DateTime addedDate;
  final String? imageUrl;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.expirationDate,
    required this.addedDate,
    this.imageUrl,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'expirationDate': expirationDate.toIso8601String(),
      'addedDate': addedDate.toIso8601String(),
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      expirationDate: DateTime.parse(json['expirationDate']),
      addedDate: DateTime.parse(json['addedDate']),
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
  // --- Firestore Integration (Veritabanı Entegrasyonu) ---

  // Firestore'dan gelen veriyi (DocumentSnapshot) alıp bizim FoodItem nesnemize çeviren "fabrika" metodu.
  // Bu metoda "Deserialization" (Tersine Serileştirme) denir.
  factory FoodItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
    snapshot, // Veritabanından gelen ham döküman
    SnapshotOptions? options,
  ) {
    final data = snapshot
        .data(); // Dökümanın içindeki veriyi Map (Sözlük) olarak alıyoruz.
    return FoodItem(
      id: snapshot
          .id, // Dökümanın benzersiz ID'sini (örn: "dKj32s...") modelimize atıyoruz.
      name:
          data?['name'] ??
          '', // Eğer isim yoksa boş string veriyoruz (Güvenlik önlemi).
      // Firestore tarihleri 'Timestamp' formatında tutar.
      // Dart ise 'DateTime' kullanır. Burada Timestamp -> DateTime dönüşümü yapıyoruz.
      expirationDate: (data?['expirationDate'] as Timestamp).toDate(),
      addedDate: (data?['addedDate'] as Timestamp).toDate(),
      imageUrl: data?['imageUrl'],
      category: data?['category'] ?? 'Genel',
    );
  }

  // Bizim FoodItem nesnemizi Firestore'un anlayacağı formata (Map) çeviren metod.
  // Bu işlem "Serialization" (Serileştirme) olarak adlandırılır.
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      // DateTime nesnesini Firestore'un istediği Timestamp formatına geri çeviriyoruz.
      'expirationDate': Timestamp.fromDate(expirationDate),
      'addedDate': Timestamp.fromDate(addedDate),
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  int get daysLeft {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Add 1 to include today in the calculation as "1 day left" if it expires tomorrow
    // If it expires today (at 00:00), difference is 0.
    final difference = expirationDate.difference(today).inDays;
    return difference;
  }

  bool get isExpired => daysLeft < 0;

  bool get isUrgent {
    if (isExpired) {
      return daysLeft < -7; // Extremely urgent if expired > 1 week ago
    }
    return daysLeft <= 2; // Urgent if 2 days or less remaining
  }

  String get timeAgo {
    if (daysLeft == 0) return 'Bugün';
    if (daysLeft == -1) return 'Dün';
    if (daysLeft < -1) return '${daysLeft.abs()} gün önce';
    return ''; // Not relevant for non-expired items usually
  }

  // Status text for Home Page
  String get statusText {
    if (daysLeft < 0) return 'Süresi Doldu';
    if (daysLeft == 0) return 'Bugün Son';
    if (daysLeft == 1) return 'Yarın Son';
    return '$daysLeft gün kaldı';
  }

  // Status color for Home Page
  Color get statusColor {
    if (daysLeft <= 0) return const Color(0xFFFF5252); // Red
    if (daysLeft <= 2) return const Color(0xFFFFAB40); // Orange
    if (daysLeft <= 5) return const Color(0xFFFFD740); // Amber
    return const Color(0xFF00E676); // Green/Mint
  }

  // Status text for Expired Page
  String get expiredStatusText {
    if (daysLeft < -7) return 'Derhal atın';
    if (daysLeft < -3) return 'Bozulmuş olabilir';
    return 'Tüketim tarihi geçti';
  }
}

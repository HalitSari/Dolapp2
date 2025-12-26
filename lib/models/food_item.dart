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
}

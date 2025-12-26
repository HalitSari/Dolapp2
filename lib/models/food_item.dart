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
}

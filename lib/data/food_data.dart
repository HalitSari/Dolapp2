class FoodInfo {
  final String name;
  final String category;
  final String storageLocation;
  final int unopenedDurationInDays;
  final int openedDurationInDays;
  final String? imagePath;

  const FoodInfo({
    required this.name,
    required this.category,
    required this.storageLocation,
    required this.unopenedDurationInDays,
    required this.openedDurationInDays,
    this.imagePath,
  });
}

class FoodData {
  static const List<FoodInfo> allItems = [
    // 1. Temel Gıdalar & Kahvaltılık
    FoodInfo(
      name: 'Ekmek (Somun)',
      category: 'Unlu Mamüller',
      storageLocation: 'Oda Sıcaklığı',
      unopenedDurationInDays: 3,
      openedDurationInDays: 2,
      imagePath: 'assets/images/bread_loaf.png',
    ),
    FoodInfo(
      name: 'Süt (UHT Kutusu)',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Kiler / Dolap',
      unopenedDurationInDays: 90,
      openedDurationInDays: 3,
      imagePath: 'assets/images/milk_carton_uht.png',
    ),
    FoodInfo(
      name: 'Süt (Günlük)',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 5,
      openedDurationInDays: 2,
      imagePath: 'assets/images/milk_bottle.png',
    ),
    FoodInfo(
      name: 'Yoğurt',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 14,
      openedDurationInDays: 6,
      imagePath: 'assets/images/yogurt_bowl.png',
    ),
    FoodInfo(
      name: 'Yumurta',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 28,
      openedDurationInDays: 28,
      imagePath: 'assets/images/eggs_bowl.png',
    ),
    FoodInfo(
      name: 'Beyaz Peynir',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 120,
      openedDurationInDays: 7,
      imagePath: 'assets/images/feta_cheese.png',
    ),
    FoodInfo(
      name: 'Kaşar Peyniri',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 150,
      openedDurationInDays: 14,
      imagePath: 'assets/images/cheddar_cheese.png',
    ),
    FoodInfo(
      name: 'Tereyağı',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 180,
      openedDurationInDays: 30,
      imagePath: 'assets/images/butter_block.png',
    ),
    FoodInfo(
      name: 'Zeytin (Salamura)',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Serin Yer/Dolap',
      unopenedDurationInDays: 365,
      openedDurationInDays: 90,
      imagePath: 'assets/images/olives_bowl.png',
    ),
    FoodInfo(
      name: 'Reçel / Bal',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Kiler/Dolap',
      unopenedDurationInDays: 365,
      openedDurationInDays: 180,
      imagePath: 'assets/images/jam_honey.png',
    ),
    FoodInfo(
      name: 'Tahin / Pekmez',
      category: 'Süt & Kahvaltılık',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 180,
      imagePath: 'assets/images/tahin_pekmez.png',
    ),

    // 2. Et & Şarküteri
    FoodInfo(
      name: 'Tavuk (Çiğ)',
      category: 'Et & Tavuk',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 2,
      openedDurationInDays: 1,
      imagePath: 'assets/images/raw_chicken_breast.png',
    ),
    FoodInfo(
      name: 'Kıyma / Kırmızı Et',
      category: 'Et & Tavuk',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 3,
      openedDurationInDays: 1,
      imagePath: 'assets/images/minced_meat_raw.png',
    ),
    FoodInfo(
      name: 'Sucuk (Vakum)',
      category: 'Şarküteri',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 90,
      openedDurationInDays: 14,
      imagePath: 'assets/images/turkish_sucuk.png',
    ),
    FoodInfo(
      name: 'Salam / Sosis',
      category: 'Şarküteri',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 60,
      openedDurationInDays: 4,
      imagePath: 'assets/images/salami_slices.png',
    ),

    // 3. Meyve & Sebze
    FoodInfo(
      name: 'Domates / Salatalık',
      category: 'Meyve & Sebze',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 7,
      openedDurationInDays: 5,
      imagePath: 'assets/images/tomatoes.png',
    ),
    FoodInfo(
      name: 'Muz',
      category: 'Meyve & Sebze',
      storageLocation: 'Oda Sıcaklığı',
      unopenedDurationInDays: 5,
      openedDurationInDays: 3,
      imagePath: 'assets/images/banana_bunch.png',
    ),
    FoodInfo(
      name: 'Marul / Yeşillik',
      category: 'Meyve & Sebze',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 5,
      openedDurationInDays: 3,
      imagePath: 'assets/images/greens_lettuce.png',
    ),
    FoodInfo(
      name: 'Elma',
      category: 'Meyve & Sebze',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 14,
      openedDurationInDays: 7,
      imagePath: 'assets/images/apple_red.png',
    ),

    // 4. Konserve & Soslar
    FoodInfo(
      name: 'Salça',
      category: 'Sos & Konserve',
      storageLocation: 'Buzdolabı',
      unopenedDurationInDays: 365,
      openedDurationInDays: 30,
      imagePath: 'assets/images/tomato_paste_can.png',
    ),
    FoodInfo(
      name: 'Ton Balığı',
      category: 'Sos & Konserve',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 1000,
      openedDurationInDays: 2,
      imagePath: 'assets/images/tuna_can.png',
    ),
    FoodInfo(
      name: 'Mısır Konservesi',
      category: 'Sos & Konserve',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 700,
      openedDurationInDays: 3,
      imagePath: 'assets/images/corn_can.png',
    ),
    FoodInfo(
      name: 'Hazır Çorba',
      category: 'Sos & Konserve',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 1, // Tüketilmeli
      imagePath: 'assets/images/instant_soup_packet.png',
    ),
    FoodInfo(
      name: 'Turşu (Kavanoz)',
      category: 'Sos & Konserve',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 30,
      imagePath: 'assets/images/pickles_jar.png',
    ),
    FoodInfo(
      name: 'Ketçap / Mayonez',
      category: 'Sos & Konserve',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 45,
      imagePath: 'assets/images/ketchup_mayo.png',
    ),

    // 5. Kuru Gıda & Bakliyat
    FoodInfo(
      name: 'Makarna / Pirinç',
      category: 'Bakliyat',
      storageLocation: 'Kiler (Kuru)',
      unopenedDurationInDays: 365,
      openedDurationInDays: 180,
      imagePath: 'assets/images/pasta_rice.png',
    ),
    FoodInfo(
      name: 'Kuru Fasulye / Nohut',
      category: 'Bakliyat',
      storageLocation: 'Kiler (Kuru)',
      unopenedDurationInDays: 700,
      openedDurationInDays: 365,
      imagePath: 'assets/images/beans_chickpeas.png',
    ),
    FoodInfo(
      name: 'Un',
      category: 'Bakliyat',
      storageLocation: 'Kiler (Serin)',
      unopenedDurationInDays: 180,
      openedDurationInDays: 90,
      imagePath: 'assets/images/flour_packet.png',
    ),

    // 6. Atıştırmalık
    FoodInfo(
      name: 'Paket Cips',
      category: 'Atıştırmalık',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 60,
      openedDurationInDays: 1,
      imagePath: 'assets/images/potato_chips.png',
    ),
    FoodInfo(
      name: 'Bisküvi / Kraker',
      category: 'Atıştırmalık',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 180,
      openedDurationInDays: 7,
      imagePath: 'assets/images/biscuits_crackers.png',
    ),
    FoodInfo(
      name: 'Tablet Çikolata',
      category: 'Atıştırmalık',
      storageLocation: 'Serin Yer',
      unopenedDurationInDays: 365,
      openedDurationInDays: 30,
      imagePath: 'assets/images/chocolate_bar.png',
    ),
    FoodInfo(
      name: 'Kuruyemiş',
      category: 'Atıştırmalık',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 90,
      openedDurationInDays: 21,
      imagePath: 'assets/images/mixed_nuts.png',
    ),

    // 7. İçecekler
    FoodInfo(
      name: 'Kola / Gazoz',
      category: 'İçecek',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 180,
      openedDurationInDays: 3,
      imagePath: 'assets/images/soda_bottles.png',
    ),
    FoodInfo(
      name: 'Meyve Suyu',
      category: 'İçecek',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 4,
      imagePath: 'assets/images/fruit_juice_bottle.png',
    ),
    FoodInfo(
      name: 'Çay (Kuru)',
      category: 'İçecek',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 365,
      imagePath: 'assets/images/tea_leaves.png',
    ),
    FoodInfo(
      name: 'Filtre Kahve',
      category: 'İçecek',
      storageLocation: 'Kiler',
      unopenedDurationInDays: 365,
      openedDurationInDays: 60,
      imagePath: 'assets/images/filter_coffee.png',
    ),
  ];
}

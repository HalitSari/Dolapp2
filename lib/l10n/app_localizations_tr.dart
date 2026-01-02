// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'DolApp';

  @override
  String get homePageTitle => 'DolApp';

  @override
  String get expiredPageTitle => 'Süresi Geçenler';

  @override
  String get recipesPageTitle => 'Tarifler';

  @override
  String get recipesUnderConstruction => 'Yapım Aşamasında';

  @override
  String get recipesComingSoon =>
      'Lezzetli tarifler çok yakında burada olacak!';

  @override
  String get settingsPageTitle => 'Ayarlar';

  @override
  String get addItemTitle => 'Ürün Ekle';

  @override
  String get tabHome => 'Ev';

  @override
  String get tabExpired => 'Süresi Geçenler';

  @override
  String get tabRecipes => 'Tarifler';

  @override
  String get emptyFridgeMessage =>
      'Dolabın boş görünüyor.\nHemen bir şeyler ekle!';

  @override
  String get emptyExpiredMessage => 'Süresi geçen ürün yok!';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün kaldı',
      one: 'Yarın Son',
      zero: 'Bugün Son',
    );
    return '$_temp0';
  }

  @override
  String get timeAgoToday => 'Bugün';

  @override
  String get timeAgoYesterday => 'Dün';

  @override
  String timeAgoPast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün önce',
      one: '1 gün önce',
    );
    return '$_temp0';
  }

  @override
  String get expiredStatus => 'Süresi Doldu';

  @override
  String get expiredWarningUrgent => 'Derhal atın';

  @override
  String get expiredWarningRisk => 'Bozulmuş olabilir';

  @override
  String get expiredWarningPast => 'Tüketim tarihi geçti';

  @override
  String get urgentLabel => 'ACİL';

  @override
  String get attentionTitle => 'Dikkat Gerekenler';

  @override
  String totalExpiredItems(int count) {
    return 'Toplam $count ürünün son tüketim tarihi geçmiş durumda.';
  }

  @override
  String get detectedTitle => 'TESPİT EDİLENLER';

  @override
  String get clearAllButton => 'Tümünü Temizle';

  @override
  String get clearAllSuccess => 'Tüm süresi geçen ürünler temizlendi!';

  @override
  String get addItemSearchLabel => 'Ekleyeceğiniz ürün';

  @override
  String get addItemSearchHint => 'Örn: Süt';

  @override
  String addItemCategory(String category) {
    return 'Kategori: $category';
  }

  @override
  String addItemLocation(String location) {
    return 'Yeri: $location';
  }

  @override
  String get isPackageOpen => 'Paketi Açık mı?';

  @override
  String get packageOpenHint => 'Daha kısa ömürlü olabilir.';

  @override
  String get packageClosedHint => 'Raf ömrü baz alınır.';

  @override
  String get dateManual => 'Seçilen SKT';

  @override
  String get dateAuto => 'Otomatik Hesaplanan SKT';

  @override
  String get dateEstimated => 'Tahmini';

  @override
  String get dateAutomaticTooltip => 'Otomatiğe Dön';

  @override
  String get addButton => 'Ekle';

  @override
  String addSuccess(String name) {
    return '\"$name\" dolabına eklendi!';
  }

  @override
  String get addErrorEmpty => 'Lütfen bir ürün adı girin.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageTitle => 'Uygulama Dili';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeTitle => 'Uygulama Teması';

  @override
  String get themeLight => 'Aydınlık';

  @override
  String get themeDark => 'Karanlık';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get languageTr => 'Türkçe';

  @override
  String get languageEn => 'English';
}

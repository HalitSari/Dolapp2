// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DolApp';

  @override
  String get homePageTitle => 'DolApp';

  @override
  String get expiredPageTitle => 'Expired Items';

  @override
  String get recipesPageTitle => 'Recipes';

  @override
  String get recipesUnderConstruction => 'Under Construction';

  @override
  String get recipesComingSoon => 'Delicious recipes will be here soon!';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get addItemTitle => 'Add Item';

  @override
  String get tabHome => 'Home';

  @override
  String get tabExpired => 'Expired';

  @override
  String get tabRecipes => 'Recipes';

  @override
  String get emptyFridgeMessage =>
      'Your fridge looks empty.\nAdd something now!';

  @override
  String get emptyExpiredMessage => 'No expired items!';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left',
      one: 'Expires Tomorrow',
      zero: 'Expires Today',
    );
    return '$_temp0';
  }

  @override
  String get timeAgoToday => 'Today';

  @override
  String get timeAgoYesterday => 'Yesterday';

  @override
  String timeAgoPast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get expiredStatus => 'Expired';

  @override
  String get expiredWarningUrgent => 'Dispose immediately';

  @override
  String get expiredWarningRisk => 'May be spoiled';

  @override
  String get expiredWarningPast => 'Expiration date passed';

  @override
  String get urgentLabel => 'URGENT';

  @override
  String get attentionTitle => 'Attention Required';

  @override
  String totalExpiredItems(int count) {
    return 'A total of $count items have passed their expiration date.';
  }

  @override
  String get detectedTitle => 'DETECTED ITEMS';

  @override
  String get clearAllButton => 'Clear All';

  @override
  String get clearAllSuccess => 'All expired items cleared!';

  @override
  String get addItemSearchLabel => 'Product to add';

  @override
  String get addItemSearchHint => 'Ex: Milk';

  @override
  String addItemCategory(String category) {
    return 'Category: $category';
  }

  @override
  String addItemLocation(String location) {
    return 'Location: $location';
  }

  @override
  String get isPackageOpen => 'Is Package Open?';

  @override
  String get packageOpenHint => 'Shelf life may be shorter.';

  @override
  String get packageClosedHint => 'Shelf life based on expiry date.';

  @override
  String get dateManual => 'Selected Expiry Date';

  @override
  String get dateAuto => 'Auto-Calculated Expiry Date';

  @override
  String get dateEstimated => 'Estimated';

  @override
  String get dateAutomaticTooltip => 'Reset to Auto';

  @override
  String get addButton => 'Add';

  @override
  String addSuccess(String name) {
    return '\"$name\" added to your fridge!';
  }

  @override
  String get addErrorEmpty => 'Please enter a product name.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageTitle => 'App Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeTitle => 'App Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageTr => 'Turkish';

  @override
  String get languageEn => 'English';
}

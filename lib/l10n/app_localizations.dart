import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'DolApp'**
  String get appTitle;

  /// No description provided for @homePageTitle.
  ///
  /// In tr, this message translates to:
  /// **'DolApp'**
  String get homePageTitle;

  /// No description provided for @expiredPageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Süresi Geçenler'**
  String get expiredPageTitle;

  /// No description provided for @recipesPageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tarifler'**
  String get recipesPageTitle;

  /// No description provided for @recipesUnderConstruction.
  ///
  /// In tr, this message translates to:
  /// **'Yapım Aşamasında'**
  String get recipesUnderConstruction;

  /// No description provided for @recipesComingSoon.
  ///
  /// In tr, this message translates to:
  /// **'Lezzetli tarifler çok yakında burada olacak!'**
  String get recipesComingSoon;

  /// No description provided for @settingsPageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsPageTitle;

  /// No description provided for @addItemTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ürün Ekle'**
  String get addItemTitle;

  /// No description provided for @tabHome.
  ///
  /// In tr, this message translates to:
  /// **'Ev'**
  String get tabHome;

  /// No description provided for @tabExpired.
  ///
  /// In tr, this message translates to:
  /// **'Süresi Geçenler'**
  String get tabExpired;

  /// No description provided for @tabRecipes.
  ///
  /// In tr, this message translates to:
  /// **'Tarifler'**
  String get tabRecipes;

  /// No description provided for @emptyFridgeMessage.
  ///
  /// In tr, this message translates to:
  /// **'Dolabın boş görünüyor.\nHemen bir şeyler ekle!'**
  String get emptyFridgeMessage;

  /// No description provided for @emptyExpiredMessage.
  ///
  /// In tr, this message translates to:
  /// **'Süresi geçen ürün yok!'**
  String get emptyExpiredMessage;

  /// No description provided for @daysLeft.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =0{Bugün Son} =1{Yarın Son} other{{count} gün kaldı}}'**
  String daysLeft(int count);

  /// No description provided for @timeAgoToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün'**
  String get timeAgoToday;

  /// No description provided for @timeAgoYesterday.
  ///
  /// In tr, this message translates to:
  /// **'Dün'**
  String get timeAgoYesterday;

  /// No description provided for @timeAgoPast.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =1{1 gün önce} other{{count} gün önce}}'**
  String timeAgoPast(int count);

  /// No description provided for @expiredStatus.
  ///
  /// In tr, this message translates to:
  /// **'Süresi Doldu'**
  String get expiredStatus;

  /// No description provided for @expiredWarningUrgent.
  ///
  /// In tr, this message translates to:
  /// **'Derhal atın'**
  String get expiredWarningUrgent;

  /// No description provided for @expiredWarningRisk.
  ///
  /// In tr, this message translates to:
  /// **'Bozulmuş olabilir'**
  String get expiredWarningRisk;

  /// No description provided for @expiredWarningPast.
  ///
  /// In tr, this message translates to:
  /// **'Tüketim tarihi geçti'**
  String get expiredWarningPast;

  /// No description provided for @urgentLabel.
  ///
  /// In tr, this message translates to:
  /// **'ACİL'**
  String get urgentLabel;

  /// No description provided for @attentionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dikkat Gerekenler'**
  String get attentionTitle;

  /// No description provided for @totalExpiredItems.
  ///
  /// In tr, this message translates to:
  /// **'Toplam {count} ürünün son tüketim tarihi geçmiş durumda.'**
  String totalExpiredItems(int count);

  /// No description provided for @detectedTitle.
  ///
  /// In tr, this message translates to:
  /// **'TESPİT EDİLENLER'**
  String get detectedTitle;

  /// No description provided for @clearAllButton.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Temizle'**
  String get clearAllButton;

  /// No description provided for @clearAllSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Tüm süresi geçen ürünler temizlendi!'**
  String get clearAllSuccess;

  /// No description provided for @addItemSearchLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ekleyeceğiniz ürün'**
  String get addItemSearchLabel;

  /// No description provided for @addItemSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn: Süt'**
  String get addItemSearchHint;

  /// No description provided for @addItemCategory.
  ///
  /// In tr, this message translates to:
  /// **'Kategori: {category}'**
  String addItemCategory(String category);

  /// No description provided for @addItemLocation.
  ///
  /// In tr, this message translates to:
  /// **'Yeri: {location}'**
  String addItemLocation(String location);

  /// No description provided for @isPackageOpen.
  ///
  /// In tr, this message translates to:
  /// **'Paketi Açık mı?'**
  String get isPackageOpen;

  /// No description provided for @packageOpenHint.
  ///
  /// In tr, this message translates to:
  /// **'Daha kısa ömürlü olabilir.'**
  String get packageOpenHint;

  /// No description provided for @packageClosedHint.
  ///
  /// In tr, this message translates to:
  /// **'Raf ömrü baz alınır.'**
  String get packageClosedHint;

  /// No description provided for @dateManual.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen SKT'**
  String get dateManual;

  /// No description provided for @dateAuto.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik Hesaplanan SKT'**
  String get dateAuto;

  /// No description provided for @dateEstimated.
  ///
  /// In tr, this message translates to:
  /// **'Tahmini'**
  String get dateEstimated;

  /// No description provided for @dateAutomaticTooltip.
  ///
  /// In tr, this message translates to:
  /// **'Otomatiğe Dön'**
  String get dateAutomaticTooltip;

  /// No description provided for @addButton.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get addButton;

  /// No description provided for @addSuccess.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" dolabına eklendi!'**
  String addSuccess(String name);

  /// No description provided for @addErrorEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen bir ürün adı girin.'**
  String get addErrorEmpty;

  /// No description provided for @settingsLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Dili'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Teması'**
  String get settingsThemeTitle;

  /// No description provided for @themeLight.
  ///
  /// In tr, this message translates to:
  /// **'Aydınlık'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In tr, this message translates to:
  /// **'Karanlık'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @languageTr.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTr;

  /// No description provided for @languageEn.
  ///
  /// In tr, this message translates to:
  /// **'English'**
  String get languageEn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

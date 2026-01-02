import 'package:dolaptakip/core/theme.dart';
import 'package:dolaptakip/pages/splash_screen.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:dolaptakip/providers/language_provider.dart';
import 'package:dolaptakip/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FridgeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'DolApp',
            debugShowCheckedModeBanner: false,
            // Temayı sağlayıcıdan al
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // Dil ayarlarını sağlayıcıdan al
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate, // Otomatik üretilen delege
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('tr', 'TR'), // Türkçe
              Locale('en', 'US'), // İngilizce
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(
      0xFFF5F7FA,
    ), // Soft cool gray/white background
    primaryColor: const Color(0xFF4CAF50), // Vibrant Red (Apple style)
    cardColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFF34C759), // Fresh Green
      surface: Colors.white,
      onSurface: Color(0xFF2D3436), // Deep charcoal for text
      error: Color(0xFF4CAF50),
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF2D3436)),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3436),
        letterSpacing: 0.5,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      elevation: 8,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    // Modern Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0F2F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
    primaryColor: const Color(0xFF4CAF50),
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter dark for cards
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFF34C759),
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: Color(0xFF4CAF50),
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      elevation: 8,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2E), // Darker input fill
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey[700]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
  );
}

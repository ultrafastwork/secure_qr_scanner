import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application theme configuration
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Color constants
  static const Color _purplePrimary = Color(0xFF8B5CF6); // violet-500
  static const Color _purpleSecondary = Color(0xFFD946EF); // fuchsia-500

  /// Light theme configuration with white background and purple accents
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _purplePrimary,
        secondary: _purpleSecondary,
        surface: Color(0xFFFAFAFA), // Light gray background
        onSurface: Color(0xFF1F1F1F), // Dark text
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA), // Light gray
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF1F1F1F), // Dark text for app bar
        iconTheme: IconThemeData(color: Color(0xFF1F1F1F)),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1F1F1F)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _purplePrimary),
      ),
    );
  }

  /// Dark theme configuration with pure black and gradient colors
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _purplePrimary,
        secondary: _purpleSecondary,
        surface: Color(0xFF000000), // pure black
        onSurface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      scaffoldBackgroundColor: const Color(0xFF000000), // pure black
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _purplePrimary),
      ),
    );
  }
}

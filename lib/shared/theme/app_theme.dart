import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _red = Color(0xFFE8002D);
  static const _bg = Color(0xFF111111);
  static const _surface = Color(0xFF1A1A1A);
  static const _card = Color(0xFF1E1E1E);
  static const _border = Color(0xFF2A2A2A);

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bg,
    colorScheme: const ColorScheme.dark(
      primary: _red,
      onPrimary: Colors.white,
      surface: _surface,
      onSurface: Colors.white,
      surfaceContainerHighest: _card,
      outline: _border,
    ),
    textTheme: GoogleFonts.titilliumWebTextTheme(ThemeData.dark().textTheme).copyWith(
      titleMedium: GoogleFonts.titilliumWeb(color: Colors.white, fontWeight: FontWeight.w600),
      bodySmall: GoogleFonts.titilliumWeb(color: const Color(0xFF888888), fontSize: 12),
      // Monospace for lap times / countdowns
      labelSmall: GoogleFonts.jetBrainsMono(color: const Color(0xFFAAAAAA), fontSize: 11),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bg,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _bg, // same color as scaffold body
      selectedItemColor: _red,
      unselectedItemColor: Color(0xFF555555),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      elevation: 0,
    ),
    dividerColor: _border,
    cardColor: _card,
    chipTheme: const ChipThemeData(
      backgroundColor: _card,
      selectedColor: _red,
      labelStyle: TextStyle(fontSize: 11, color: Colors.white),
      side: BorderSide(color: Color(0xFF333333), width: 0.5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: _red,
      unselectedLabelColor: Color(0xFF666666),
      indicatorColor: _red,
      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _card,
      hintStyle: const TextStyle(color: Color(0xFF555555), fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _border, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _border, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _red, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
  );

  /// Team colours map
  static const Map<String, Color> teamColors = {
    'mclaren': Color(0xFFFF8000),
    'red_bull': Color(0xFF182852),
    'ferrari': Color(0xFFE8002D),
    'mercedes': Color(0xFF27F4D2),
    'aston_martin': Color(0xFF0A7968),
    'alpine': Color(0xFFFF87BC),
    'williams': Color(0xFF00A3E0),
    'haas': Color(0xFFB6BABD),
    'rb': Color.fromARGB(255, 227, 255, 102),
    'cadillac': Color(0xFFFFFFFF),
  };

  static Color teamColor(String constructorId) =>
      teamColors[constructorId.toLowerCase()] ?? const Color(0xFF888888);
}

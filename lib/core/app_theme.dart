import 'package:flutter/material.dart';

class AppColors {
  static const Color fondo = Color(0xFF1A1C21);
  static const Color superficie = Color(0xFF262932);
  static const Color superficieClara = Color(0xFF30343F);
  static const Color naranja = Color(0xFFE8964A);
  static const Color marron = Color(0xFF7A5232);
  static const Color texto = Colors.white;
  static const Color textoSecundario = Color(0xFF9AA0AE);
}

ThemeData buildSportZoneTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.naranja,
      onPrimary: Colors.black,
      surface: AppColors.superficie,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.fondo,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.naranja,
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.superficie,
      hintStyle: const TextStyle(color: AppColors.textoSecundario, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.fondo,
      selectedItemColor: AppColors.naranja,
      unselectedItemColor: AppColors.textoSecundario,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

import 'package:flutter/material.dart';

final ThemeData chatAppGreenTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF4CAF50), // Soft Green
  scaffoldBackgroundColor: Color(0xFFF1F8E9), // Light Greenish Background
  colorScheme: ColorScheme.light(
    primary: Color(0xFF4CAF50), // Soft Green
    secondary: Color(0xFF81C784), // Light Green
    background: Color(0xFFF1F8E9), // Background Color
    surface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF388E3C), // Darker Green for AppBar
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF388E3C),
      side: BorderSide(color: Color(0xFF388E3C)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF4CAF50)), // Soft Green
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF81C784)), // Light Green
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF2C6B39), // Dark Greenish Slate
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFF2C6B39), // Dark Greenish Slate
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);

final ThemeData chatAppDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1B5E20), // Deep Green
  scaffoldBackgroundColor: Color(0xFF121212), // Dark Background
  cardColor: Color(0xFF1E1E1E), // Dark Mode Card Background
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF66BB6A), // Lighter Green
    secondary: Color(0xFF81C784), // Soft Green
    background: Color(0xFF121212), // Dark Mode Background
    surface: Color(0xFF1E1E1E), // Dark Mode Surface
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1B5E20), // Dark Green for AppBar
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.white70,
    ),
  ),
);

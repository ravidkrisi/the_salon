import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF005B99), // Deep blue for primary elements
    onPrimary: Colors.white, // Text/icons on primary color
    secondary: Color(0xFFFFA726), // Warm orange for accents
    onSecondary: Colors.white,
    surface: Colors.white, // Default container background
    onSurface: Colors.black87, // Text/icons on surfaces
    error: Color(0xFFD32F2F), // Standard error red
    onError: Colors.white, // Text/icons on error surfaces
  ),
);

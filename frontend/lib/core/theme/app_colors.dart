import 'package:flutter/material.dart';

/// Deep Ocean Editorial Color Palette
/// A sophisticated, distinctive palette avoiding generic AI aesthetics
class AppColors {
  AppColors._();

  // Primary Deep Ocean Colors
  static const Color primaryDeep = Color(0xFF0A1628);
  static const Color primarySurface = Color(0xFF132137);
  static const Color primaryLight = Color(0xFF1E3A5F);
  
  // Accent Colors
  static const Color accentCoral = Color(0xFFFF6B5B);
  static const Color accentCoralLight = Color(0xFFFF8A7D);
  static const Color accentGold = Color(0xFFE8B84D);
  static const Color accentGoldLight = Color(0xFFF5D080);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF5F5F0);
  static const Color textSecondary = Color(0xFF8B9EB3);
  static const Color textMuted = Color(0xFF5A6B7D);
  
  // Functional Colors
  static const Color success = Color(0xFF4ECDC4);
  static const Color successLight = Color(0xFF7EDDD6);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFBE5B);
  
  // Surface Colors
  static const Color surfaceGlass = Color(0xB3132137); // 70% opacity
  static const Color surfaceCard = Color(0xFF1A2D47);
  static const Color surfaceDivider = Color(0xFF2A3F5F);
  
  // Gradient Colors
  static const List<Color> gradientPrimary = [
    Color(0xFF0A1628),
    Color(0xFF132137),
    Color(0xFF1E3A5F),
  ];
  
  static const List<Color> gradientCoral = [
    Color(0xFFFF6B5B),
    Color(0xFFFF8A7D),
  ];
  
  static const List<Color> gradientGold = [
    Color(0xFFE8B84D),
    Color(0xFFF5D080),
  ];
}

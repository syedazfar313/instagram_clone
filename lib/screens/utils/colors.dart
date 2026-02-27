import 'package:flutter/material.dart';

class AppColors {
  static const Color background    = Color(0xFF000000);
  static const Color surface       = Color(0xFF111111);
  static const Color surface2      = Color(0xFF1A1A1A);
  static const Color border        = Color(0xFF262626);
  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA8A8A8);
  static const Color blue          = Color(0xFF0095F6);
  static const Color red           = Color(0xFFED4956);

  static const LinearGradient storyGradient = LinearGradient(
    colors: [
      Color(0xFFF09433), Color(0xFFE6683C),
      Color(0xFFDC2743), Color(0xFFCC2366), Color(0xFFBC1888),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
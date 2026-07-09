import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.racingRed,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.racingRed,
        secondary: AppColors.electricTeal,
        surface: AppColors.surface,
        background: AppColors.background,
      ),
      // Font utama pakai 'Outfit' yang modern & bersih. 
      // Font angka/display pakai 'Space Grotesk' biar terkesan alat ukur digital.
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain, 
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.outfit(color: AppColors.textMain),
        bodyMedium: GoogleFonts.outfit(color: AppColors.textSecondary),
      ),
      // Setelan bentuk "Kartu" UI (Card) melengkung halus 20px
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}



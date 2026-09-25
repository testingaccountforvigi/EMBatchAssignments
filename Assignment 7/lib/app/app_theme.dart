import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens. The palette is borrowed from risograph gig posters:
/// lilac paper stock, violet ink, one hot pink spot colour.
class AppColors {
  const AppColors._();

  static const Color paperLilac = Color(0xFFE9E4F5);
  static const Color card = Color(0xFFFCFBFF);
  static const Color ink = Color(0xFF201A38);
  static const Color inkSoft = Color(0xFF6F669B);
  static const Color ultraviolet = Color(0xFF4B33C9);
  static const Color risoPink = Color(0xFFFF5C8A);
  static const Color mint = Color(0xFF2BB89C);
  static const Color hairline = Color(0xFFD5CDEC);
}

/// Spacing and radius tokens keep every screen on the same rhythm.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 6;
  static const double sm = 12;
  static const double md = 20;
  static const double lg = 28;
  static const double xl = 40;

  static const double radiusField = 18;
  static const double radiusCard = 26;
}

class AppTheme {
  const AppTheme._();

  /// Comfortaa is the roundest of the Google display faces - used only for
  /// headings. Quicksand carries the body copy with matching soft terminals.
  static TextTheme _textTheme() {
    final TextTheme base = ThemeData.light().textTheme;
    final TextTheme body = GoogleFonts.quicksandTextTheme(base);

    return body.copyWith(
      displaySmall: GoogleFonts.comfortaa(
        fontSize: 36,
        height: 1.15,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: AppColors.ink,
      ),
      headlineSmall: GoogleFonts.comfortaa(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.ink,
      ),
      titleMedium: GoogleFonts.comfortaa(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),
      bodyLarge: GoogleFonts.quicksand(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      ),
      bodyMedium: GoogleFonts.quicksand(
        fontSize: 14.5,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.inkSoft,
      ),
      labelLarge: GoogleFonts.quicksand(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }

  static ThemeData get light {
    final TextTheme text = _textTheme();

    OutlineInputBorder border(Color c, [double w = 1.4]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusField),
          borderSide: BorderSide(color: c, width: w),
        );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.paperLilac,
      textTheme: text,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.ultraviolet,
        primary: AppColors.ultraviolet,
        secondary: AppColors.risoPink,
        surface: AppColors.card,
        error: AppColors.risoPink,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.ink),
        titleTextStyle: text.titleMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: border(AppColors.hairline),
        enabledBorder: border(AppColors.hairline),
        focusedBorder: border(AppColors.ultraviolet, 1.8),
        errorBorder: border(AppColors.risoPink),
        focusedErrorBorder: border(AppColors.risoPink, 1.8),
        labelStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
          color: AppColors.inkSoft,
        ),
        floatingLabelStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.w700,
          color: AppColors.ultraviolet,
        ),
        helperStyle: GoogleFonts.quicksand(
          fontSize: 12.5,
          color: AppColors.inkSoft,
        ),
        errorStyle: GoogleFonts.quicksand(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: AppColors.risoPink,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ultraviolet,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(58),
          textStyle: text.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusField),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.ultraviolet,
          textStyle: text.labelLarge,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: GoogleFonts.quicksand(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

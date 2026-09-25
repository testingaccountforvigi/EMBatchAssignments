import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for every color, text style and component theme used
/// in the app. Keeping this separate from `main.dart` means the whole
/// visual identity of the app can be changed from one file.
class AppTheme {
  AppTheme._();

  // ---- Brand palette -----------------------------------------------
  // A calm indigo/teal duo instead of Flutter's stock Material blue,
  // paired with a warm off-white background so the UI doesn't feel
  // like a default scaffold.
  static const Color primary = Color(0xFF5B5FEF); // indigo
  static const Color primaryDark = Color(0xFF3D3FBF);
  static const Color accent = Color(0xFF19C6A6); // teal accent
  static const Color background = Color(0xFFF6F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1B1D29);
  static const Color textSecondary = Color(0xFF6B6F84);
  static const Color error = Color(0xFFE5484D);
  static const Color success = Color(0xFF19A974);
  static const Color warning = Color(0xFFF5A623);
  static const Color cardBorder = Color(0xFFEDEEF4);

  static const List<Color> avatarPalette = [
    Color(0xFF5B5FEF),
    Color(0xFF19C6A6),
    Color(0xFFF5A623),
    Color(0xFFE5484D),
    Color(0xFF9B5DE5),
    Color(0xFF00B4D8),
  ];

  static Color avatarColorFor(int seed) =>
      avatarPalette[seed % avatarPalette.length];

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
        error: error,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
    );

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      headlineSmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: -0.3,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 14.5,
        color: textPrimary,
        height: 1.45,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 13.5,
        color: textSecondary,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: cardBorder, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: cardBorder,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 13),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      colorScheme: base.colorScheme.copyWith(
        surface: surface,
        error: error,
      ),
    );
  }
}

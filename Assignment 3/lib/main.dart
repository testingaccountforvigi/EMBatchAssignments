import 'package:flutter/material.dart';

import 'profile_card.dart';

void main() {
  runApp(const ProfileApp());
}

/// Root application widget — configuration only. All layout and
/// interaction logic lives in [ProfileScreen] (see profile_card.dart).
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const ProfileScreen(),
    );
  }

  /// A deliberate, restrained theme: a warm canvas, near-black ink for
  /// text, and a single oxblood accent — applied consistently to every
  /// component style below instead of relying on Material defaults.
  ThemeData _buildTheme() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);

    final colorScheme = base.colorScheme.copyWith(
      primary: AppColors.ink,
      onPrimary: AppColors.canvas,
      secondary: AppColors.accent,
      onSecondary: AppColors.canvas,
      surface: AppColors.canvas,
      onSurface: AppColors.ink,
      // Material 3 tints elevated surfaces with the primary color by
      // default. Disabling that keeps our own palette in control.
      surfaceTint: Colors.transparent,
      error: const Color(0xFFB3261E),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.canvas,
      dividerColor: AppColors.hairline,
      splashFactory: InkRipple.splashFactory,
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      iconTheme: const IconThemeData(color: AppColors.ink, size: 20),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.canvas,
          disabledBackgroundColor: AppColors.hairline,
          elevation: 0,
          minimumSize: const Size.fromHeight(46),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          minimumSize: const Size.fromHeight(46),
          side: const BorderSide(color: AppColors.hairline, width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.ink,
          minimumSize: const Size(46, 46),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: const TextStyle(color: AppColors.canvas, fontSize: 12),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(
          color: AppColors.canvas,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.all(14),
        hintStyle: const TextStyle(color: AppColors.stone, fontSize: 14.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.4),
        ),
      ),
    );
  }
}

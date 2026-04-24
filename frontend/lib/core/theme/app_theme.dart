import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF00E676);
  static const Color secondary = Color(0xFF03AE75);
  static const Color tertiary = Color(0xFF00DCFD);
  static const Color neutral = Color(0xFF121212);
  static const Color _surfaceL1 = Color(0xFF1A1A1A);
  static const Color _textHigh = Color(0xFFFFFFFF);
  static const Color _textMedium = Color(0xFFA0A0A0);
  static const Color _border = Color(0xFF333333);
  static const Color _error = Color(0xFFFF4D4D);

  static ThemeData get darkTheme {
    final baseTextTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).textTheme;

    var textTheme = GoogleFonts.manropeTextTheme(baseTextTheme);

    textTheme = textTheme.copyWith(
      displayLarge: GoogleFonts.notoSerif(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.02,
        color: _textHigh,
      ),
      headlineMedium: GoogleFonts.notoSerif(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01,
        color: _textHigh,
      ),
      titleLarge: GoogleFonts.notoSerif(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _textHigh,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _textHigh,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.01,
        color: _textHigh,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: _textMedium,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.02,
        color: _textHigh,
      ),
    );

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: neutral,
      secondary: secondary,
      onSecondary: neutral,
      tertiary: tertiary,
      onTertiary: neutral,
      error: _error,
      onError: _textHigh,
      surface: neutral,
      onSurface: _textHigh,
      onSurfaceVariant: _textMedium,
      outline: _border,
      outlineVariant: _border,
      surfaceContainerLowest: _backgroundBase,
      surfaceContainerLow: _surfaceL1,
      surfaceContainer: _surfaceL1,
      surfaceContainerHigh: _surfaceL2,
      surfaceContainerHighest: _surfaceL2,

      // ignore: deprecated_member_use
      background: _backgroundBase,
      onBackground: _textHigh,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: neutral,
      cardColor: _surfaceL1,
      dividerColor: _border,
      hintColor: _textMedium,
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: neutral,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // pill shaped
          ),
          textStyle: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: neutral,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: _surfaceL1,
        hintStyle: GoogleFonts.manrope(
          color: _textMedium,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1),
        ),
      ),
    );
  }
}

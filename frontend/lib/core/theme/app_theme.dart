import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryNeon = Color(0xFF00FF7F);
  static const Color _backgroundBase = Color(0xFF0A0A0A);
  static const Color _surfaceL1 = Color(0xFF1A1A1A);
  static const Color _surfaceL2 = Color(0xFF262626);
  static const Color _textHigh = Color(0xFFFFFFFF);
  static const Color _textMedium = Color(0xFFA0A0A0);
  static const Color _border = Color(0xFF333333);
  static const Color _error = Color(0xFFFF4D4D);

  static ThemeData get darkTheme {
    final baseTextTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).textTheme;

    var textTheme = GoogleFonts.plusJakartaSansTextTheme(baseTextTheme);

    textTheme = textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.02,
        color: _textHigh,
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01,
        color: _textHigh,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _textHigh,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _textHigh,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.01,
        color: _textHigh,
      ),
      labelSmall: textTheme.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: _textMedium,
      ),
      labelLarge: textTheme.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.02,
        color: _textHigh,
      ),
    );

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: _primaryNeon,
      onPrimary: _backgroundBase,
      secondary: _primaryNeon,
      onSecondary: _backgroundBase,
      error: _error,
      onError: _textHigh,
      surface: _surfaceL1,
      onSurface: _textHigh,
      onSurfaceVariant: _textMedium,
      outline: _border,
      outlineVariant: _border,
      surfaceContainerLowest: _backgroundBase,
      surfaceContainerLow: _surfaceL1,
      surfaceContainer: _surfaceL1,
      surfaceContainerHigh: _surfaceL2,
      surfaceContainerHighest: _surfaceL2,

      background: _backgroundBase,

      onBackground: _textHigh,
    );

    final buttonTextStyle = GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.02,
      color: _backgroundBase,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundBase,
      cardColor: _surfaceL1,
      dividerColor: _border,
      hintColor: _textMedium,
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryNeon,
          foregroundColor: _backgroundBase,
          disabledBackgroundColor: _surfaceL2,
          disabledForegroundColor: _textMedium,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: buttonTextStyle,
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: _surfaceL2,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: _textMedium,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        constraints: const BoxConstraints(maxHeight: 52),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _border, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _primaryNeon, width: 1),
        ),
      ),
      cardTheme: CardThemeData(
        color: _surfaceL1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: _border,
        thickness: 1,
      ),
    );
  }
}

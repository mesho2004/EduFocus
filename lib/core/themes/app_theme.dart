import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color background;
  final Color cardBackground;
  final Color border;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  final Color brandRed;
  final Color brandOrange;
  final Color brandYellow;
  final Color brandGreen;
  final Color brandCyan;
  final Color brandBlue;
  final Color brandPurple;

  const AppColorsExtension({
    required this.primary,
    required this.background,
    required this.cardBackground,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.brandRed,
    required this.brandOrange,
    required this.brandYellow,
    required this.brandGreen,
    required this.brandCyan,
    required this.brandBlue,
    required this.brandPurple,
  });

  static final light = AppColorsExtension(
    primary: AppColors.primary,
    background: AppColors.backgroundLight,
    cardBackground: Colors.white,
    border: AppColors.slate200,
    textPrimary: AppColors.slate900,
    textSecondary: AppColors.slate600,
    textTertiary: AppColors.slate400,
    brandRed: AppColors.brandRed,
    brandOrange: AppColors.brandOrange,
    brandYellow: AppColors.brandYellow,
    brandGreen: AppColors.brandGreen,
    brandCyan: AppColors.brandCyan,
    brandBlue: AppColors.brandBlue,
    brandPurple: AppColors.brandPurple,
  );

  static final dark = AppColorsExtension(
    primary: AppColors.primary,
    background: AppColors.backgroundDark,
    cardBackground: const Color(0xFF1E293B),
    border: const Color(0xFF334155),
    textPrimary: Colors.white,
    textSecondary: const Color(0xFFCBD5E1),
    textTertiary: const Color(0xFF64748B),
    brandRed: const Color(0xFFEF4444),
    brandOrange: const Color(0xFFF97316),
    brandYellow: const Color(0xFFFBBF24),
    brandGreen: const Color(0xFF34D399),
    brandCyan: const Color(0xFF22D3EE),
    brandBlue: const Color(0xFF60A5FA),
    brandPurple: const Color(0xFFC084FC),
  );

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? background,
    Color? cardBackground,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? brandRed,
    Color? brandOrange,
    Color? brandYellow,
    Color? brandGreen,
    Color? brandCyan,
    Color? brandBlue,
    Color? brandPurple,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      cardBackground: cardBackground ?? this.cardBackground,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      brandRed: brandRed ?? this.brandRed,
      brandOrange: brandOrange ?? this.brandOrange,
      brandYellow: brandYellow ?? this.brandYellow,
      brandGreen: brandGreen ?? this.brandGreen,
      brandCyan: brandCyan ?? this.brandCyan,
      brandBlue: brandBlue ?? this.brandBlue,
      brandPurple: brandPurple ?? this.brandPurple,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      brandRed: Color.lerp(brandRed, other.brandRed, t)!,
      brandOrange: Color.lerp(brandOrange, other.brandOrange, t)!,
      brandYellow: Color.lerp(brandYellow, other.brandYellow, t)!,
      brandGreen: Color.lerp(brandGreen, other.brandGreen, t)!,
      brandCyan: Color.lerp(brandCyan, other.brandCyan, t)!,
      brandBlue: Color.lerp(brandBlue, other.brandBlue, t)!,
      brandPurple: Color.lerp(brandPurple, other.brandPurple, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: GoogleFonts.lexendTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.backgroundLight,
        brightness: Brightness.light,
      ),
      extensions: [AppColorsExtension.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: GoogleFonts.lexendTextTheme(ThemeData.dark().textTheme),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.backgroundDark,
        brightness: Brightness.dark,
      ),
      extensions: [AppColorsExtension.dark],
    );
  }
}

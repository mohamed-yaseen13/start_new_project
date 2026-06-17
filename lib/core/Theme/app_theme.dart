import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar_themes.dart';
import 'app_color.dart';
import 'app_text_styles.dart';

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

class AppTheme {
  AppTheme._();

  // ================= LIGHT =================

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    fontFamily: "DIN",

    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      secondary: AppColor.secondaryColor,
      tertiary: AppColor.tertiaryColor,
      surfaceContainerHighest: Colors.grey.shade100, // cards, sheets
    ),

    scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,

    dividerColor: Colors.transparent,

    splashFactory: NoSplash.splashFactory,

    cardTheme: CardThemeData(color: Colors.grey.shade100, elevation: 0),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    appBarTheme: lightAppBarTheme,

    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headline,
      titleMedium: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
    ),
  );

  // ================= DARK =================

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: "DIN",

    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColor.primaryColor,
      onPrimary: Colors.white,
      onPrimaryContainer: Color(0xFFC7BFB8), // 👈 your old value
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceContainerHighest:
          Colors.grey.shade900, // dark variant for cards/sheets
      secondary:
          AppColor.secondaryColor, // to be updated to activate the dark theme
      tertiary:
          AppColor.tertiaryColor, // to be updated to activate the dark theme
    ),

    scaffoldBackgroundColor: Colors.black,

    dividerColor: Colors.transparent,

    splashFactory: NoSplash.splashFactory,

    cardTheme: CardThemeData(
      color: Colors.grey.shade900,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    appBarTheme: darkAppBarTheme,

    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headline,
      titleMedium: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
    ),
  );
}

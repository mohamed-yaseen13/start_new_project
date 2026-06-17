import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_text_styles.dart';
import 'app_system_ui.dart';

final AppBarTheme lightAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent, // use transparent + system overlay
  elevation: 0,
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.black), // or ColorScheme.onPrimary
  titleTextStyle: AppTextStyles.title.copyWith(
    color: Colors.black, // or context.colors.onPrimary
  ),
  systemOverlayStyle: AppSystemUi.light(),
  surfaceTintColor: AppColor.scaffoldBackgroundColor,
);

final AppBarTheme darkAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.white), // or ColorScheme.onPrimary
  titleTextStyle: AppTextStyles.title.copyWith(
    color: Colors.white, // or context.colors.onPrimary
  ),
  systemOverlayStyle: AppSystemUi.dark(),
);

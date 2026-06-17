import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class AppSystemUi {
  // Dark overlay (used with dark theme)
  static SystemUiOverlayStyle dark({Color? navBarColor}) {
    return SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, // iOS
      statusBarIconBrightness: Brightness.light, // Android icons
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: navBarColor ?? Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }

  // Light overlay (used with light theme)
  static SystemUiOverlayStyle light({Color? navBarColor}) {
    return SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // iOS
      statusBarIconBrightness: Brightness.dark, // Android icons
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: navBarColor ?? Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }

  // Auto from context
  static SystemUiOverlayStyle fromTheme() {
    final isDark =
        Theme.of(Constants.globalContext()).brightness == Brightness.dark;
    return isDark ? dark() : light();
  }
}

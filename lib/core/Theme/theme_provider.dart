import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper_function/prefs.dart';
import 'app_system_ui.dart';
import 'app_theme.dart';


class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = sharedPreferences.getBool("is_dark") ?? false;
  void changeTheme() {
    isDarkMode = !isDarkMode;
    sharedPreferences.setBool("is_dark", isDarkMode);
    notifyListeners();
  }
  ThemeData getTheme() {
    final baseTheme = isDarkMode ? AppTheme.dark : AppTheme.light;
    return baseTheme;
  }

  /// Returns SystemUiOverlayStyle for current theme (use in main or pages if needed)
  SystemUiOverlayStyle get overlayStyle =>
      isDarkMode ? AppSystemUi.dark() : AppSystemUi.light();
}




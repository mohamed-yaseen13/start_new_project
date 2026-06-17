import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../domain/use_cases/translate_text.dart';
import 'dart:ui' as ui;

class LanguageProvider extends ChangeNotifier {
  late Locale
  language; // use this var when control state of language widget then use it for change language
  late Locale _appLocale;
  static const List<Locale> languages = [Locale('ar', ''), Locale("en", "")];
  Locale get appLocal => _appLocale;
  static String? languageCode() {
    return sharedPreferences.getString('language_code');
  }

  static bool isAr() {
    return languageCode() == 'ar';
  }

  Future<String?> checkLanguageCode() async {
    String? language = sharedPreferences.getString('language_code');
    return language;
  }

  static TextDirection direction() {
    if (sharedPreferences.getString("language_code") == "ar") {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  Future fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    Locale locale = ui.PlatformDispatcher.instance.locale;

    String? language = prefs.getString('language_code');
    if (language == null) {
      if (!['ar', 'en'].contains(locale.languageCode)) {
        locale = Locale('ar');
      }
      _appLocale = locale;
      this.language = locale;
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
    } else {
      _appLocale = Locale(language);
      this.language = Locale(language);
    }
    notifyListeners();
  }

  Future changeLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    _appLocale = language;
    await prefs.setString('language_code', language.languageCode);
    ApiHandel.getInstance.updateHeader(
      sharedPreferences.getString('token') ?? "",
      language: language.languageCode,
    );
    notifyListeners();
  }

  void setLanguage(Locale locale, {bool rebuild = true}) {
    language = locale;
    if (rebuild) notifyListeners();
  }

  void rebuild() {
    notifyListeners();
  }

  String getTranslate(String key, value) {
    Map localizedStrings =
        ApiHandel.getInstance.languages[_appLocale.languageCode];
    if (localizedStrings.containsKey(key) &&
        localizedStrings[key].containsKey(value)) {
      return localizedStrings[key][value];
    }
    return value;
  }

  static String translate(String key, String value) {
    // LanguageProvider languageProvider = Provider.of(Constants.globalContext(),listen: false);
    // return languageProvider.getTranslate(key,value);
    return Translate.translate(key, value);
  }
}

import '../../features/language/presentation/providers/language_provider.dart';

class ArabicPeriodFormatter {
  /// type: 'day' or 'month', duration: the count
  static String format(String type, int duration) {
    return LanguageProvider.isAr()
        ? _formatArabic(type, duration)
        : _formatEnglish(type, duration);
  }

  /// Arabic counted-noun rules:
  /// 1        -> singular alone           (يوم)
  /// 2        -> dual alone               (يومان)
  /// 3-10     -> number + plural          (٣ أيام)
  /// 11+      -> number + singular        (١٣ يوم)
  static String _formatArabic(String type, int duration) {
    if (duration == 1) {
      return LanguageProvider.translate('rent_periods', '${type}_singular');
    }
    if (duration == 2) {
      return LanguageProvider.translate('rent_periods', '${type}_dual');
    }
    if (duration >= 3 && duration <= 10) {
      final plural = LanguageProvider.translate(
        'rent_periods',
        '${type}_plural',
      );
      return '$duration $plural';
    }
    // 11 and above: goes back to singular form, but with the number shown
    final singular = LanguageProvider.translate(
      'rent_periods',
      '${type}_singular',
    );
    return '$duration $singular';
  }

  /// English rules: just singular for 1, plural (with number) for everything else.
  static String _formatEnglish(String type, int duration) {
    if (duration == 1) {
      return LanguageProvider.translate('rent_periods', '${type}_singular');
    }
    final plural = LanguageProvider.translate('rent_periods', '${type}_plural');
    return '$duration $plural';
  }
}

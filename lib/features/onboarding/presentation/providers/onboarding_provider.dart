import 'package:flutter/material.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../pages/onboarding_page.dart';

class OnboardingProvider extends ChangeNotifier {
  void goTo() {
    setIsFirstTime(false);
    navPR(OnboardingPage());
  }
}

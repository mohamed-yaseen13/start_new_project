import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../onboarding/presentation/providers/onboarding_provider.dart';

class SplashProvider extends ChangeNotifier {
  void startApp() async {
    await Future.wait([
      // Provider.of<SettingsProvider>(Constants.globalContext(), listen: false).getSettings(),
      // Provider.of<CategoriesProvider>(Constants.globalContext(), listen: false).refresh(),
      // Provider.of<CityProvider>(Constants.globalContext(), listen: false).getCities(),
    ]);
    await delay(1000);
    // isEndAnimation= true;
    // var settingsProvider = Provider.of<SettingsProvider>(Constants.globalContext(),listen: false);
    // SettingsEntity? settings = settingsProvider.settingsEntity;
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // if(int.parse(packageInfo.buildNumber)<settings!.version){
    //   await updateDialog(settings.mustUpdate);
    //   if(settings.mustUpdate){
    //     return;
    //   }
    // }

    // String? login = sharedPreferences.getString('token');
    // if(login !=null){
    //     Provider.of<AuthProvider>(Constants.globalContext(),listen: false).getProfile(fromSplash: true);
    // }else{
    //   Provider.of<AuthProvider>(Constants.globalContext(), listen: false).goToLoginPage();
    // }
    if (getIsFirstTime()) {
      // First time - go to onboarding
      Provider.of<OnboardingProvider>(
        Constants.globalContext(),
        listen: false,
      ).goTo();
    } else {
      Provider.of<OnboardingProvider>(
        Constants.globalContext(),
        listen: false,
      ).goTo();
      // Not first time - check for auth token
      // String? token = sharedPreferences.getString('token');
      // if (token != null) {
      //   // User is logged in - go to main layout
      //   Provider.of<NavigationBarProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).goToPage();
      // } else {
      //   // User not logged in - go to login
      //   Provider.of<NavigationBarProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).goToPage();
      //   Provider.of<AdsProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).getData();
      //   Provider.of<CategoriesProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).getData();
      //   Provider.of<SubCategoryHomeProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).getData();
      //   Provider.of<ChatsProvider>(
      //     Constants.globalContext(),
      //     listen: false,
      //   ).getChats();
    }
  }

  void clear() {
    // introEntity = null;
    notifyListeners();
  }
}

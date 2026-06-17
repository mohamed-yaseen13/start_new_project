import 'package:flutter/material.dart';

class Constants {
  static const String baseUri = 'https://api.tajeer.cloud/';

  static const String webSocketLink =
      'wss://api.tajeer.cloud/app/d6jhrfdqasdssnhnfoymotajjer?protocol=7&client=js&version=8.4.0&flash=false';
  static const String domain = '${baseUri}api/';
  //! for navigation
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static bool isTablet = false;

  static BuildContext globalContext() {
    return navState.currentContext!;
  }

}

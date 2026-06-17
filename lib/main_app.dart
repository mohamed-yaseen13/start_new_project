import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/Theme/app_system_ui.dart';
import 'core/Theme/theme_provider.dart';
import 'core/constants/constants.dart';
import 'core/models/progress_provider.dart';
import 'features/language/domain/entities/app_localizations.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/splash_screen/presentation/pages/splash_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, lang, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 825),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, orientation) {
            Constants.isTablet = 1.sw >= 600;
            return AnnotatedRegion(
              value: AppSystemUi.light(),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return MaterialApp(
                    title: 'سيارات - Cars',
                    debugShowCheckedModeBanner: false,
                    navigatorObservers: [routeObserver],
                    navigatorKey: Constants.navState,
                    locale: lang.appLocal,
                    supportedLocales: LanguageProvider.languages,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    theme: themeProvider.getTheme(),
                    home: const SplashPage(),
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 1.sw,
                            height: 1.sh,
                            child: Stack(
                              children: [
                                child!,
                                Positioned(
                                  bottom: 0,
                                  child: Consumer<ProgressProvider>(
                                    builder: (ctx, pro, _) {
                                      return pro.showBottomSheetDialog();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

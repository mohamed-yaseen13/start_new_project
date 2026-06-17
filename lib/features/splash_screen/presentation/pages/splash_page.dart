import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/Theme/app_system_ui.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/helper_function.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/logo_widget.dart';
import '../providers/splash_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await delay(100);
      Provider.of<SplashProvider>(
        Constants.globalContext(),
        listen: false,
      ).startApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: AppSystemUi.light(),
        child: Container(
          color: Colors.white,
          width: 1.sw,
          height: 1.sh,
          child: Center(
            child: LogoWidget(width: 0.5.sw, height: 0.2.sh),
          ),
        ),
      ),
    );
  }
}

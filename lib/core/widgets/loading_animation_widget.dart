import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';

class LoadingAnimationWidget extends StatelessWidget {
  const LoadingAnimationWidget({
    super.key,
    required this.gif,
    this.width,
    this.height,
    this.topPadding,
  });
  final double? width;
  final double? height;
  final double? topPadding;
  final String gif;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(gif, fit: BoxFit.cover, width: width, height: height),
        SizedBox(height: .05.sh),
        Text(
          LanguageProvider.translate("global", "loading"),
          style: context.text.bodyMedium,
        ),
      ],
    );
  }
}

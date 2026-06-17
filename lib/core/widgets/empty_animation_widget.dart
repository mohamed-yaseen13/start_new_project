import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class EmptyAnimationWidget extends StatelessWidget {
  const EmptyAnimationWidget({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.gif,
    this.aboveText,
  });

  final double? width;
  final double? height;
  final String title;
  final String gif;
  final bool? aboveText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (aboveText != null && aboveText!)
          Text(
            LanguageProvider.translate("empty", title),
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          ),
        SizedBox(height: .01.sh),
        Lottie.asset(
          gif,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        SizedBox(height: .01.sh),
        if (aboveText == null)
          Text(
            LanguageProvider.translate("empty", title),
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          ),
      ],
    );
  }
}

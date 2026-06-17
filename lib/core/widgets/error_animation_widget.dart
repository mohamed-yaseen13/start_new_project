import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import 'button_widget.dart';

class ErrorAnimationWidget extends StatelessWidget {
  const ErrorAnimationWidget({
    super.key,
    this.width,
    this.height,
    this.title,
    required this.gif,
    required this.onRefresh,
    this.aboveText,
    this.refresh,
  });

  final double? width;
  final double? height;
  final String? title, refresh;
  final String gif;
  final bool? aboveText;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (aboveText != null && aboveText!)
          Text(
            LanguageProvider.translate("warning", title ?? "try_again"),
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          ),
        SizedBox(height: .01.sh),
        Lottie.asset(gif, fit: BoxFit.cover, width: width, height: height),
        SizedBox(height: .01.sh),
        if (aboveText == null)
          Text(
            LanguageProvider.translate("warning", title ?? "try_again"),
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          ),
        SizedBox(height: 0.01.sh),
        ButtonWidget(
          onTap: onRefresh,
          text: refresh ?? 'refresh',
          width: .5.sw,
        ),
      ],
    );
  }
}

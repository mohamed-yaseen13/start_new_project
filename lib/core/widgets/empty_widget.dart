import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String image;
  final double? width;
  const EmptyWidget({
    super.key,
    required this.title,
    required this.image,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            image,
            width: width ?? .70.sw,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          LanguageProvider.translate("empty", title),
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

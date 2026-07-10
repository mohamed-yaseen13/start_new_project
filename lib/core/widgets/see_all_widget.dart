import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/providers/language_provider.dart';
// import '../constants/app_images.dart';
// import 'svg_widget.dart';

class SeeAllWidget extends StatelessWidget {
  final String text;
  final bool? seeAll;
  final VoidCallback onTap;
  final bool isThereIcon;

  const SeeAllWidget({
    super.key,
    required this.text,
    this.seeAll = true,
    required this.onTap,
    this.isThereIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LanguageProvider.translate('see_all', text),
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (seeAll == true)
          GestureDetector(
            onTap: onTap,
            child: isThereIcon
                ? Row(
                    children: [
                      Text(
                        LanguageProvider.translate("global", "see_all"),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Color(0xFF6B6056),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // SvgWidget(svg: AppImages.seeAllIcon),
                    ],
                  )
                : Text(
                    LanguageProvider.translate("global", "see_all"),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Color(0xFF6B6056),
                    ),
                  ),
          ),
      ],
    );
  }
}

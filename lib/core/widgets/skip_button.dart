import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
            side: BorderSide(color: context.colors.tertiary),
          ),
        ),
        child: Text(
          LanguageProvider.translate('global', 'skip'),
          style: context.text.bodySmall,
        ),
      ),
    );
  }
}

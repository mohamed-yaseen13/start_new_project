import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../features/language/presentation/providers/language_provider.dart';
import '../Theme/app_theme.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  final VoidCallback onTap;

  const DontHaveAnAccountWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: LanguageProvider.translate('auth', 'dont_have_an_account'),
            style: context.text.bodyMedium,
          ),
          TextSpan(
            text: LanguageProvider.translate('auth', 'signup'),
            style: context.text.bodyMedium!.copyWith(
              color: context.colors.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

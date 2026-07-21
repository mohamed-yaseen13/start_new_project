import 'package:flutter/material.dart';
import '../../features/language/presentation/providers/language_provider.dart';

class SeeAllWidget extends StatelessWidget {
  final String text;
  final bool? seeAll;
  final VoidCallback? onTap;

  const SeeAllWidget({
    super.key,
    required this.text,
    this.seeAll = true,
    this.onTap,
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
          InkWell(
            onTap: onTap,
            child: Text(
              LanguageProvider.translate("global", "see_all"),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

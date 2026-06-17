import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // context.read<LoginProvider>().goTo();
        },
        child: Text(
          LanguageProvider.translate('signup', 'already_have_an_account'),
          style: context.text.bodyMedium,
        ),
      ),
    );
  }
}

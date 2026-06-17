import 'package:flutter/material.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';
// import 'package:provider/provider.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.read<SignupProvider>().goTo();
      },
      child: Text(
        LanguageProvider.translate('login', 'dont_have_an_account'),
        style: context.text.bodyMedium,
      ),
    );
  }
}

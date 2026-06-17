import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class ValidationWidget extends StatelessWidget {
  const ValidationWidget({super.key, required this.conditions, this.child});

  final List<Map<String, dynamic>> conditions;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField(
      validator: (_) {
        for (var condition in conditions) {
          if (condition['value'] == true) {
            return LanguageProvider.translate('validation', condition['text']);
          }
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ?child,
            if (state.hasError) SizedBox(height: .005.sh),
            if (state.hasError)
              Text(
                state.errorText!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        );
      },
    );
  }
}

// class Example extends StatelessWidget {
//   const Example({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // pick address
//         ValidationWidget(conditions: [{"value":addressProvider.selectedAddress==null,"text":"Select Address"}])
//       ],
//     );
//   }
// }

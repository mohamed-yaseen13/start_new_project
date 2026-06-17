import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/app_lotties.dart';
import '../constants/constants.dart';
import '../helper_function/helper_function.dart';
import '../helper_function/navigation.dart';
import '../Theme/app_theme.dart'; // make sure your ThemeX is imported

Future successDialog({
  dynamic then,
  String? msg,
  String? lottie,
  int? millSec,
}) async {
  bool close = false;

  final context = Constants.globalContext();

  showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.surfaceContainerHighest,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: 1.sw,
            constraints: BoxConstraints(
              maxHeight: Constants.isTablet ? .50.sh : .35.sh,
              minHeight: Constants.isTablet ? .50.sh : .35.sh,
            ),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: .05.sw),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: .03.sh),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (.30.sw) / 2),
                      child: Lottie.asset(
                        lottie ?? AppLottie.success,
                        fit: BoxFit.contain,
                        width: .40.sw,
                      ),
                    ),
                    SizedBox(height: .02.sh),
                    Text(
                      LanguageProvider.translate('success', msg ?? 'success'),
                      style: context.text.bodyMedium, // <-- themed
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then((value) {
    close = true;
    if (then != null) then();
  });

  delay(millSec ?? 2000).then((_) {
    if (!close) navPop();
  });
}

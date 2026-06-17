import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';
import '../constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String text, {
  Color? color,
  String? title,
  bool normal = false,
}) {
  final context = Constants.globalContext();
  final theme = context.theme;
  if (normal) {
    Fluttertoast.showToast(
      msg: LanguageProvider.translate('warning', text),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: color ?? context.colors.primary,
      textColor: Colors.white,
      fontSize: 13.sp,
    );
    return;
  }
  final materialBanner = MaterialBanner(
    elevation: 2,
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 01.sh * 0.3,
        minHeight: 80,
        minWidth: 0.50.sw,
        maxWidth: 0.9.sw,
      ),
      child: AwesomeSnackbarContent(
        inMaterialBanner: true,
        title: LanguageProvider.translate('error', title ?? 'error'),
        message: text.replaceAll(
          '\n',
          "\n----------------------------------------------\n",
        ),
        contentType: ContentType.warning,
        messageTextStyle: context.text.bodyMedium!.copyWith(
          fontSize: Constants.isTablet ? 30 : 15.sp,
          color: theme.colorScheme.onPrimary,
        ),
        titleTextStyle: context.text.titleMedium!.copyWith(
          fontSize: Constants.isTablet ? 40 : 13.sp,
          color: theme.colorScheme.onPrimary,
        ),
        color: color ?? theme.colorScheme.primary,
      ),
    ),
    actions: const [SizedBox.shrink()],
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);

  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(Constants.globalContext()).hideCurrentMaterialBanner();
  });
}

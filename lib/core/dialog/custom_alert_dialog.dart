import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_theme.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../widgets/svg_widget.dart';

void customAlertDialog({
  String? image,
  required String title,
  required String content,
  double? top,
  required String confirm,
  Color? color,
  Color? backConfirm,
  Color? backCancel,
  Color? desColor,
  Color? confirmTextColor,
  Color? cancelTextColor,
  required void Function() confirmTap,
  bool? confirmFound,
  double? padding,
  required String cancel,
  required void Function() cancelTap,
}) {
  final context = Constants.globalContext();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final theme = context.theme;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.01.sh),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            clipBehavior: Clip.none,
            children: [
              if (image != null)
                Positioned(
                  top: top ?? -0.16.sh,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: 0.35.sw,
                    height: 0.38.sw,
                    padding: EdgeInsets.all(padding ?? 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          color ??
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    child: image.contains('.svg')
                        ? SvgWidget(svg: image, fit: BoxFit.contain)
                        : Image.asset(image, fit: BoxFit.contain),
                  ),
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LanguageProvider.translate('warning', title),
                    style: context.text.titleMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 0.05.sh),
                  Text(
                    LanguageProvider.translate('warning', content),
                    style: context.text.bodyMedium!.copyWith(
                      color:
                          desColor ??
                          theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 0.03.sh),
                  Row(
                    children: [
                      if (confirmFound == null)
                        Expanded(
                          child: InkWell(
                            onTap: confirmTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.04.sw,
                                vertical: 0.01.sh,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: backConfirm ?? theme.colorScheme.primary,
                              ),
                              child: Text(
                                LanguageProvider.translate('buttons', confirm),
                                style: context.text.bodyMedium!.copyWith(
                                  color:
                                      confirmTextColor ??
                                      theme.colorScheme.onPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if (confirmFound == null) SizedBox(width: 0.01.sw),
                      Expanded(
                        child: InkWell(
                          onTap: cancelTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.04.sw,
                              vertical: 0.01.sh,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color:
                                  backCancel ??
                                  theme.colorScheme.surfaceContainerHighest,
                            ),
                            child: Text(
                              LanguageProvider.translate('buttons', cancel),
                              style: context.text.bodyMedium!.copyWith(
                                color:
                                    cancelTextColor ??
                                    theme.colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

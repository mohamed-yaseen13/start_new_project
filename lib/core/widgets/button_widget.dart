import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  final double? width, height, borderRadius, elevation;
  final void Function() onTap;
  final Color? color, borderColor;
  final String text;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? directionBorderRadius;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool widgetAfterText, takeSmallestWidth, withShadow;
  final bool? isSpaceBetween;
  final double? spacing;

  const ButtonWidget({
    this.spacing,
    this.widget,
    this.width,
    this.withShadow = false,
    this.height,
    this.directionBorderRadius,
    required this.onTap,
    this.borderRadius,
    required this.text,
    this.textStyle,
    this.borderColor,
    this.color,
    this.widgetAfterText = true,
    super.key,
    this.takeSmallestWidth = false,
    this.elevation,
    this.padding,
    this.isSpaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      elevation: withShadow ? (elevation ?? 2) : 0,
      borderRadius:
      directionBorderRadius ?? BorderRadius.circular(borderRadius ?? 8),
      color: color ?? colors.primary,
      child: InkWell(

        onTap: onTap,
        child: Container(
          width: takeSmallestWidth ? null : (width ?? .9.sw),
          height: height ?? (Constants.isTablet ? .07.sh : .065.sh),
          padding: padding ?? EdgeInsets.symmetric(horizontal: .02.sw),
          decoration: BoxDecoration(
            borderRadius:
            directionBorderRadius ?? BorderRadius.circular(borderRadius ?? 8),
            color: color ?? colors.primary,
            border: borderColor != null && color != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          child: Row(
            mainAxisAlignment: isSpaceBetween == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (!widgetAfterText) widget ?? const SizedBox(),
              Text(
                LanguageProvider.translate("buttons", text),
                style: textStyle ??
                    textTheme.bodyMedium?.copyWith(
                      color: colors.onPrimary,
                      fontSize: 16.sp,
                    ),
              ),
              if (isSpaceBetween == true) const SizedBox(),
              if (widgetAfterText) widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

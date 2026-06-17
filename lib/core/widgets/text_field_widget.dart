import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_theme.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final bool obscureText, autoFocus, otp, readOnly, next, isLabel;
  final TextEditingController controller;
  final double? width,
      height,
      verticalPadding,
      borderRadius,
      elevation,
      borderWidth;
  final Widget? titleWidget, prefix, suffix;
  final void Function(String)? onChange;
  final void Function()? onTextTap, onEditingComplete, onSuffixTap;
  final int? maxLines, maxLength, minLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? counter, hintText;
  final Color? color,
      borderColor,
      cursorColor,
      focusedBorder,
      enabledBorder,
      hintColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  const TextFieldWidget({
    this.maxLines,
    this.hintText,
    this.cursorColor,
    required this.controller,
    this.height,
    this.width,
    this.style,
    this.focusedBorder,
    this.enabledBorder,
    this.isLabel = false,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.counter,
    this.autoFocus = false,
    this.keyboardType,
    this.maxLength,
    this.next = true,
    this.obscureText = false,
    this.textAlign,
    this.onChange,
    this.onEditingComplete,
    this.onSuffixTap,
    this.otp = false,
    this.prefix,
    this.readOnly = false,
    this.suffix,
    this.onTextTap,
    this.titleWidget,
    this.validator,
    this.verticalPadding,
    super.key,
    this.minLines,
    this.contentPadding,
    this.elevation,
    this.borderWidth,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? .01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleWidget != null) ...[titleWidget!, SizedBox(height: .008.sh)],
          Material(
            borderRadius: BorderRadius.circular(borderRadius ?? .03.sw),
            elevation: elevation ?? 0,
            color: Colors.transparent,
            child: SizedBox(
              width: width ?? 1.sw,
              height: height,
              child: TextFormField(
                controller: controller,
                textAlign: textAlign ?? TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                obscureText: obscureText,
                onChanged: onChange,
                onTap:
                    onTextTap ??
                    () {
                      final c = controller;
                      if (c.selection ==
                          TextSelection.fromPosition(
                            TextPosition(offset: c.text.length - 1),
                          )) {
                        c.selection = TextSelection.fromPosition(
                          TextPosition(offset: c.text.length),
                        );
                      }
                    },
                minLines: minLines,
                maxLines: maxLines ?? 1,
                maxLength: maxLength,
                keyboardType: keyboardType,
                readOnly: readOnly,
                autofocus: autoFocus,
                cursorColor: cursorColor ?? theme.colorScheme.primary,
                style: style ?? theme.textTheme.bodyMedium,
                validator:
                    validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return LanguageProvider.translate(
                          'validation',
                          'field',
                        );
                      }
                      return null;
                    },
                onEditingComplete:
                    onEditingComplete ??
                    () {
                      FocusScope.of(context).unfocus();
                      if (next) FocusScope.of(context).nextFocus();
                    },
                decoration: inputDecoration(theme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(ThemeData theme) {
    final borderClr =
        borderColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.5);

    return InputDecoration(
      counterText: counter ?? "",
      isDense: true,
      hintText: hintText == null
          ? null
          : LanguageProvider.translate('inputs', hintText!),
      fillColor: color ?? theme.inputDecorationTheme.fillColor ?? Colors.white,
      filled: true,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: hintColor ?? Constants.globalContext().colors.secondary,
        height: 1.2,
      ),
      labelStyle: theme.textTheme.bodySmall?.copyWith(
        color: const Color(0xff8F8C8C),
      ),
      floatingLabelStyle: theme.textTheme.bodySmall,
      floatingLabelBehavior: isLabel
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.never,
      border: focusedBorder != null
          ? null
          : border(
              borderRadius: borderRadius,
              color: borderClr,
              otp: otp,
              borderWidth: borderWidth,
            ),
      disabledBorder: border(
        borderRadius: borderRadius,
        color: borderClr,
        otp: otp,
      ),
      focusedBorder: border(
        borderRadius: borderRadius,
        color: focusedBorder ?? borderClr,
        borderWidth: focusedBorder == null ? 0 : 2,
        otp: otp,
      ),
      enabledBorder: border(
        borderRadius: borderRadius,
        color: enabledBorder ?? borderClr,
        borderWidth: borderWidth,
        otp: otp,
      ),
      errorBorder: border(
        borderRadius: borderRadius,
        color: Colors.red,
        otp: otp,
      ),
      focusedErrorBorder: border(
        borderRadius: borderRadius,
        color: Colors.red,
        otp: otp,
      ),
      hoverColor: Colors.grey,
      prefixIcon: prefix,
      suffixIcon:
          suffix ??
          (onSuffixTap == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    size: 20,
                    color: obscureText
                        ? Colors.grey
                        : theme.colorScheme.primary,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )),
      contentPadding:
          contentPadding ??
          EdgeInsets.only(
            left: .03.sw,
            right: .05.sw,
            top: Constants.isTablet ? .014.sh : .019.sh,
            bottom: .022.sh,
          ),
      errorStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
    );
  }

  static InputBorder border({
    Color? color,
    double? borderRadius,
    double? borderWidth,
    bool otp = false,
  }) {
    if (otp) {
      return UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color: color ?? const Color(0xff8F8C8C),
          width: borderWidth ?? 2,
        ),
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        color: color ?? const Color(0xff8F8C8C),
        width: borderWidth ?? 1,
      ),
    );
  }
}

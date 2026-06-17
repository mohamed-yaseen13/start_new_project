import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_color.dart';
import '../constants/constants.dart';
import '../models/text_field_model.dart';
import 'svg_widget.dart';
import 'text_field_widget.dart';

class ListTextFieldWidget extends StatelessWidget {
  const ListTextFieldWidget({
    super.key,
    required this.inputs,
    this.style,
    this.color,
    this.borderColor,
    this.textColor,
    this.errorStyleColor,
    this.borderRadius,

    this.borderWidth,
  });

  final List<TextFieldModel> inputs;
  final TextStyle? style;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor, errorStyleColor, textColor, color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final defaultTextStyle = style ?? theme.textTheme.bodyMedium;

    List telInputs = ['phone', 'whats', 'whatsapp'];

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(inputs.length, (index) {
          final input = inputs[index];
          final finalTextColor = textColor ?? colors.onSurface;

          return TextFieldWidget(
            borderRadius: borderRadius ?? .03.sw,
            borderWidth: borderWidth,
            titleWidget: Builder(
              builder: (ctx) {
                if (input.titleWidgets != null) {
                  return Row(children: [...input.titleWidgets!]);
                }

                if (input.title != null) return input.title!;

                if (input.editTextString != null) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        input.editTextString!,
                        style: defaultTextStyle?.copyWith(
                          color: finalTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: .01.sw),
                    ],
                  );
                }

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (input.image != null)
                      SvgWidget(
                        svg: input.image!,
                        width: Constants.isTablet ? 5.w : null,
                        color: finalTextColor,
                      ),
                    if (input.image != null) SizedBox(width: .02.sw),
                    if (input.label != null)
                      Text(
                        LanguageProvider.translate('inputs', input.label!),
                        style: defaultTextStyle?.copyWith(
                          color: finalTextColor,
                        ),
                      ),
                  ],
                );
              },
            ),
            color: color ?? AppColor.scaffoldBackgroundColor,
            borderColor: borderColor ?? colors.tertiary,
            isLabel: input.isLabel ?? false,
            maxLength: telInputs.contains(input.key) ? 10 : null,
            controller: input.controller,
            keyboardType: input.textInputType,
            next: inputs.length - 1 != index,
            hintText: input.hint,
            onTextTap: input.onTap,
            minLines: input.min,
            maxLines: input.max,
            validator: input.validator,
            obscureText: input.obscureText,
            suffix: input.suffix,
            prefix: input.prefix,
            readOnly: input.readOnly,
            width: input.width,
            contentPadding: input.contentPadding,
          );
        }),
      ),
    );
  }
}

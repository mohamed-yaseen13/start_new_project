import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    this.color,
    this.textStyle,
  });

  final String price;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.primary;
    final defaultTextStyle =
        textStyle ?? theme.textTheme.titleMedium?.copyWith(color: defaultColor);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(price, style: defaultTextStyle),
        SizedBox(width: 6.w),
        // SvgWidget(
        //   svg: AppImages.riyal,
        //   width: .04.sw,
        //   color: defaultColor,
        // ),
      ],
    );
  }
}

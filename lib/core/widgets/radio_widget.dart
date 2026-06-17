import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.selected,
    this.onTap,
    this.color,
  });

  final bool selected;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: Constants.isTablet ? .05.sw : .05.sw,
        height: Constants.isTablet ? .05.sw : .05.sw,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: effectiveColor,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(.07.sw),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? effectiveColor : null,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

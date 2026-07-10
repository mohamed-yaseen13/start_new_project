import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants.dart';

Future<void> bottomSheetDialog(Widget child) async {
  await showModalBottomSheet(
    context: Constants.globalContext(),
    isScrollControlled: true,
    builder: (bottomSheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFCF9F8),
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 18.w,
            vertical: 12.h,
          ),
          child: child,
        ),
      );
    },
  );
}

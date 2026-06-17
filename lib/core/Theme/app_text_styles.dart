import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headline =>
      TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get title =>
      TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body =>
      TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get caption =>
      TextStyle(
        fontSize: 12.sp,
        color: Colors.grey,
      );
}

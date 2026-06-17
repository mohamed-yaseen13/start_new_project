import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  final Widget child;

  const CustomBottomNavBarWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 48.h, top: 12.h),
      child: Column(mainAxisSize: MainAxisSize.min, children: [child]),
    );
  }
}

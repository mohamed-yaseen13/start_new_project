import 'package:flutter/material.dart';
import 'app_text_styles.dart';

TabBarTheme lightTabBarTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.tab,

  // text styles (reused)
  labelStyle: AppTextStyles.body.copyWith(
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: AppTextStyles.body,

  // colors (Material roles)
  labelColor: Colors.black,          // onSurface (light)
  unselectedLabelColor: Colors.grey, // caption / onSurfaceVariant

  indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 2,
      color: Colors.black, // onSurface (light)
    ),
  ),
);

TabBarTheme darkTabBarTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.tab,

  // text styles (reused)
  labelStyle: AppTextStyles.body.copyWith(
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: AppTextStyles.body,

  // colors (Material roles)
  labelColor: Colors.white,          // onSurface (dark)
  unselectedLabelColor: Colors.grey, // caption / onSurfaceVariant

  indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 2,
      color: Colors.white, // onSurface (dark)
    ),
  ),
);

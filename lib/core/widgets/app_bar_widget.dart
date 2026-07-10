import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/providers/language_provider.dart';
import '../Theme/app_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isThereActions;
  final bool isFavorited;

  const AppBarWidget({
    super.key,
    required this.title,
    this.isThereActions = false,
    this.isFavorited = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 24.h),
      child: AppBar(
        centerTitle: true,
        title: Text(
          LanguageProvider.translate('app_bar', title),
          style: context.text.headlineLarge!.copyWith(fontSize: 20.sp),
        ),
        actions: isThereActions
            ? [
                isFavorited
                    ? Icon(Icons.favorite, color: Colors.red, size: 24.sp)
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                SizedBox(width: 24.w),
              ]
            : [],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

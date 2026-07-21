import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/providers/language_provider.dart';
import '../Theme/app_theme.dart';
import '../helper_function/navigation.dart';
import '../widgets/button_widget.dart';

class GuestDialog extends StatelessWidget {
  const GuestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   AppImages.logoutImage,
          //   width: 79.w,
          //   height: 87.h,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(height: 12.h),
          Text(
            LanguageProvider.translate('auth', 'logout'),
            style: context.text.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            LanguageProvider.translate('auth', 'logout2'),
            style: context.text.bodyMedium,
          ),

          SizedBox(height: 12.h),
          TextButton(
            onPressed: () {
              navPop();
              // Constants.globalContext().read<LoginProvider>().goTo();
            },
            child: Text(
              LanguageProvider.translate('buttons', 'logout'),
              style: context.text.titleMedium!.copyWith(
                fontSize: 16.sp,
                color: context.colors.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ButtonWidget(
              onTap: () {
                navPop();
              },
              text: 'cancel',
              color: Color(0xFFFE5E48),
              textStyle: context.text.headlineLarge!.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void checkGuest(Function onTap) async {
  // if (ProfileProvider.isLogin) {
  //   onTap();
  // } else {
  //   await bottomSheetDialog(GuestDialog());
  // }
}

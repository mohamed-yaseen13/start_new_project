import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_lotties.dart';
import '../constants/constants.dart';
import 'navigation.dart';

bool isLoadingStart = false;
void loading() {
  if (!isLoadingStart) {
    isLoadingStart = true;
    showDialog(
      context: Constants.globalContext(),
      barrierDismissible: false,
      barrierColor: Colors.white.withValues(alpha: 0),
      builder: (BuildContext context) {
        return PopScope(
          canPop: true,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              width: 1.sw,
              height: 1.sh,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: .30.sw,
                  height: .30.sw,
                  padding: EdgeInsets.all(.02.sw),
                  child: Center(
                    child: Lottie.asset(
                      AppLottie.loading,
                      width: .30.sw,
                      height: .30.sw,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      isLoadingStart = false;
    });
  }
}

void navPopLoading() {
  if (isLoadingStart) {
    isLoadingStart = false;
    navPop();
  }
}

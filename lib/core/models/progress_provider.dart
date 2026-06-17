import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../helper_function/api.dart';
import '../theme/app_theme.dart';

class ProgressProvider extends ChangeNotifier {
  int sent = 0;
  int total = 0;

  void setData(int sent, int total) {
    if (total > 0) {
      this.sent = sent;
      this.total = total;
      notifyListeners();
    }
  }

  void clear() {
    sent = 0;
    total = 0;
    notifyListeners();
  }

  Widget showBottomSheetDialog() {
    if ((sent == 0 && total == 0) || total == 0) return const SizedBox();

    final num progress = ((sent / total) * 100).toInt() == 100
        ? 99
        : ((sent / total) * 100).toInt();
    BuildContext context = Constants.globalContext();
    final colors = context.colors;

    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 1.sw,
              height: 0.20.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
                color: colors.surface, // ✅ theme-aware popup background
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 0.05.sw,
                vertical: 0.02.sh,
              ),
              child: Column(
                children: [
                  // Title + Cancel Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LanguageProvider.translate('global', 'loading'),
                        style: context.text.titleMedium!.copyWith(
                          color: colors.onSurface,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (sent != total) {
                            ApiHandel.getInstance.cancelFunction();
                            clear();
                          }
                        },
                        child: Text(
                          LanguageProvider.translate('buttons', 'cancel'),
                          style: context.text.bodyMedium!.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Progress %
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$progress %',
                        style: context.text.bodyMedium!.copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Progress Bar
                  Container(
                    width: 0.90.sw,
                    height: 2.h,
                    decoration: BoxDecoration(
                      color:
                          colors.surfaceContainerHighest, // ✅ track background
                      borderRadius: BorderRadius.circular(150.r),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 0.90.sw * (sent / total),
                      height: 2.h,
                      child: Shimmer.fromColors(
                        baseColor: colors.primary,
                        highlightColor: colors.primary.withValues(alpha: 0.7),
                        direction: ShimmerDirection.ltr,
                        child: Container(
                          width: 0.90.sw * (sent / total),
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: colors.primary, // ✅ fill color
                            borderRadius: BorderRadius.circular(150.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

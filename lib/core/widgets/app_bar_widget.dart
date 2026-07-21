import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/providers/language_provider.dart';
import '../Theme/app_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isThereActions;
  // final CarEntity? car;

  const AppBarWidget({
    super.key,
    required this.title,
    this.isThereActions = false,
    // this.car,
  });

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<FavoriteProvider>();

    return AppBar(
      centerTitle: true,
      title: Text(
        LanguageProvider.translate('app_bar', title),
        style: context.text.headlineLarge!.copyWith(fontSize: 20.sp),
      ),
      // for car app bar
      // actions: isThereActions
      //     ? [
      //         if(car!=null)InkWell(
      //           onTap: () {
      //             provider.toggleFavorite(car!);
      //           },
      //           child: Icon(
      //             provider.favoriteIds.contains(car!.id)
      //                 ? Icons.favorite
      //                 : Icons.favorite_border,
      //             color: provider.favoriteIds.contains(car!.id)
      //                 ? Colors.red
      //                 : Colors.black,
      //             size: 24.sp,
      //           ),
      //         ),
      //         SizedBox(width: 24.w),
      //       ]
      //     : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

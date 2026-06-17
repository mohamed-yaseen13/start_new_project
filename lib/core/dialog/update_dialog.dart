// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart';
// import '../../features/language/presentation/provider/language_provider.dart';
// import '../constants/constants.dart';
// import '../helper_function/navigation.dart';
// import '../theme/app_text_styles.dart';
// import '../theme/theme_provider.dart';

// Future updateAppDialog(SettingsEntity settings) async {
//   final rootContext = Constants.globalContext();

//   await showCupertinoModalPopup<void>(
//     context: rootContext,
//     builder: (BuildContext context) {
//       final colors = context.colors;

//       return CupertinoAlertDialog(
//         title: Text(
//           LanguageProvider.translate('update_dialog', 'new_update'),
//           style: AppTextStyles.title.copyWith(
//             color: colors.onSurface,
//           ),
//         ),
//         actions: <CupertinoDialogAction>[
//           CupertinoDialogAction(
//             onPressed: () async {
//               StoreRedirect.redirect(
//                 androidAppId: settings.userPackageName,
//                 iOSAppId: settings.useAppId,
//               );
//             },
//             isDefaultAction: true,
//             child: Text(
//               LanguageProvider.translate('update_dialog', 'update'),
//               style: AppTextStyles.body.copyWith(
//                 color: colors.primary, // ✅ theme primary
//               ),
//             ),
//           ),
//           if (!settings.mustUpdate)
//             CupertinoDialogAction(
//               onPressed: navPop,
//               child: Text(
//                 LanguageProvider.translate('update_dialog', 'cancel'),
//                 style: AppTextStyles.body.copyWith(
//                   color: colors.onSurface, // ✅ adapts to dark/light
//                 ),
//               ),
//             ),
//         ],
//       );
//     },
//   );
// }

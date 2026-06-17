// import 'package:provider/provider.dart';

// import '../constants/app_images.dart';
// import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import 'custom_alert_dialog.dart';

void showGuestDialog() {
  customAlertDialog(
    // image: AppImages.guestDiaolg,
    title: 'must_login',
    content: 'must_login_first',
    cancel: 'cancel',
    confirm: 'login',
    cancelTap: () {
      navPop();
    },
    confirmTap: () {
      // Provider.of<LoginProvider>(Constants.globalContext(), listen: false,).goToLoginPage();
      // navPARU(const UserTypeView());
    },
  );
}

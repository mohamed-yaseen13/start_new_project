import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';
import '../constants/constants.dart';
import '../dialog/snack_bar.dart';
import '../widgets/image/pick_image_page.dart';
import '../widgets/image/pick_video_page.dart';
import 'helper_function.dart';
import 'navigation.dart';

//how can use

// Single image
// final XFile? image = await chooseMedia<XFile>(context: context);
//
// // Multi-image
// final List<XFile>? images = await chooseMedia<List<XFile>>(context: context, multiple: true);
//
// // Video
// final XFile? video = await chooseMedia<XFile>(context: context, video: true);

/// Generic image/video picker
Future<T?> chooseMedia<T>({bool video = false, bool multiple = false}) async {
  final picker = ImagePicker();

  Future<T?> pickFromSource(ImageSource source) async {
    if (video) {
      if (multiple) return null; // Video multi not supported here
      final XFile? file = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 5),
      );
      return file as T?;
    } else {
      if (multiple) {
        final List<XFile> files = await picker.pickMultiImage();
        return files as T?;
      } else {
        final XFile? file = await picker.pickImage(
          source: source,
          imageQuality: 80,
        );
        return file as T?;
      }
    }
  }

  Future<bool> checkPermissions() async {
    Permission permission;
    if (video) {
      permission = Permission.camera;
      final micStatus = await Permission.microphone.status;
      if (!micStatus.isGranted) await Permission.microphone.request();
    } else {
      permission = multiple ? Permission.mediaLibrary : Permission.camera;
    }

    final status = await permission.status;
    if (status.isGranted) return true;

    final result = await permission.request();
    if (result.isGranted) return true;

    showToast(LanguageProvider.translate('warning', 'access_camera'));
    return false;
  }

  BuildContext context = Constants.globalContext();
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (ctx) => Transform.scale(
      scale: Constants.isTablet ? 1.2 : 1,
      child: CupertinoAlertDialog(
        title: Text(
          LanguageProvider.translate('image_picker', 'pick'),
          style: context.text.titleMedium!.copyWith(
            color: context.colors.onSurface,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              if (await checkPermissions()) {
                if (video) {
                  navP(
                    const AddVideoPage(),
                    then: (val) async {
                      await delay(400);
                      navPop(val);
                    },
                  );
                } else if (multiple) {
                  navP(
                    AddImagePage(multiple: true),
                    then: (val) async {
                      await delay(100);
                      navPop(val);
                    },
                  );
                } else {
                  final T? file = await pickFromSource(ImageSource.camera);
                  Navigator.pop(Constants.globalContext(), file);
                }
              }
            },
            child: Text(
              LanguageProvider.translate('image_picker', 'camera'),
              style: context.text.bodyMedium!.copyWith(
                color: context.colors.primary,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              if (await checkPermissions()) {
                final T? file = await pickFromSource(ImageSource.gallery);
                Navigator.pop(Constants.globalContext(), file);
              }
            },
            child: Text(
              LanguageProvider.translate('image_picker', 'gallery'),
              style: context.text.bodyMedium!.copyWith(
                color: context.colors.primary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

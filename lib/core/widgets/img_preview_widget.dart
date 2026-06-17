import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import 'button_widget.dart';

class ImagePreviewWidget extends StatelessWidget {
  final XFile? img;
  final String? imgPath;
  final bool showSendButton;

  const ImagePreviewWidget({
    this.img,
    this.imgPath,
    super.key,
    required this.showSendButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colors.surface, // theme-aware
        bottomNavigationBar: img == null && !showSendButton
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(
                    onTap: () {
                      navPop();
                      // Provider.of<MessageProvider>(context, listen: false)
                      //     .addMessage(file: img!, type: 'image');
                    },
                    text: 'send',
                    textStyle: textTheme.bodyMedium?.copyWith(
                      color: colors.onPrimary,
                    ),
                    color: colors.primary,
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: colors.surface, // theme-aware
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colors.onSurface, // theme-aware
              size: 6.w,
            ),
            onPressed: () => Navigator.of(Constants.globalContext()).pop(),
          ),
          title: const SizedBox(),
        ),
        body: Container(
          width: 1.sw,
          height: .95.sh,
          decoration: BoxDecoration(
            image: img == null
                ? DecorationImage(
                    image: CachedNetworkImageProvider(imgPath!),
                    fit: BoxFit.contain,
                  )
                : DecorationImage(
                    image: FileImage(File(img!.path)),
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}

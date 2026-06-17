import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../constants/constants.dart';
import '../helper_function/navigation.dart';

class ImagesPreviewWidget extends StatelessWidget {
  final List<dynamic> images;
  final int? index;

  const ImagesPreviewWidget({required this.images, this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface, // theme-aware background
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          children: [
            PageView.builder(
              controller: PageController(initialPage: index ?? 0),
              itemCount: images.length,
              itemBuilder: (context, idx) {
                final image = images[idx];
                ImageProvider imgProvider;

                if (image is XFile) {
                  imgProvider = FileImage(File(image.path));
                } else if (image is String) {
                  imgProvider = CachedNetworkImageProvider(image);
                } else {
                  throw Exception("Unsupported image type");
                }

                return PinchZoom(
                  maxScale: 2.5,
                  child: Container(
                    width: 1.sw,
                    height: 1.sh,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imgProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
            PositionedDirectional(
              top: .08.sh,
              start: .03.sw,
              child: Container(
                margin: EdgeInsets.all(.015.sw),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.onSurface.withValues(alpha: 0.3), // theme-aware
                ),
                child: Transform.scale(
                  scale: Constants.isTablet ? 2 : 1,
                  child: BackButton(
                    color: colors.primary, // theme-aware
                    onPressed: navPop,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

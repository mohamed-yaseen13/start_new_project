import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../helper_function/image.dart';

class UploadMultiImageWidget extends StatelessWidget {
  const UploadMultiImageWidget({
    super.key,
    required this.images,
    required this.count,
    required this.deleteImage,
    required this.imagesList,
    this.title,
  });

  final List images;
  final String? title;
  final int count;
  final void Function(int i) deleteImage;
  final void Function(List<XFile> images) imagesList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.005.sh),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          List<XFile>? pickedImages = await chooseMedia<List<XFile>?>();
          if (pickedImages != null) imagesList(pickedImages);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0.5.h),
              child: Text(
                LanguageProvider.translate(
                  'image_picker',
                  title ?? 'upload_image',
                ).replaceAll('*count*', count.toString()),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 0.10.sh,
              child: Row(
                children: [
                  // Add button
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0.01.sh),
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.04.sw,
                      vertical: 0.015.sh,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: theme.colorScheme.primary,
                    ),
                    child: FlutterLogo(),
                    // child: SvgWidget(svg: AppImages.uploadImage),
                  ),
                  // Images List
                  if (images.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          final image = images[i];
                          final imageProvider = (image is XFile)
                              ? FileImage(File(image.path))
                              : CachedNetworkImageProvider(image.image)
                                    as ImageProvider;

                          return InkWell(
                            onTap: () => deleteImage(i),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Container(
                                width: 0.18.sw,
                                height: 0.14.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            // Footer row
            Row(
              children: [
                if (images.isNotEmpty)
                  Text(
                    LanguageProvider.translate('image_picker', 'delete_image'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                const Spacer(),
                Text(
                  '${images.length}/$count',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

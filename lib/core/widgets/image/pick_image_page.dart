import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helper_function/navigation.dart';
import '../../../features/language/presentation/provider/language_provider.dart';
import '../../Theme/app_system_ui.dart';
import '../../Theme/app_theme.dart';
import '../../constants/constants.dart';
import '../../helper_function/helper_function.dart';
import '../../helper_function/loading.dart';
import '../button_widget.dart';
import '../imgs_preview_widget.dart';
import 'package:image/image.dart' as img;

class AddImagePage extends StatefulWidget {
  final bool multiple;
  const AddImagePage({super.key, required this.multiple});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  CameraController? _controller;
  double _currentZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  List<XFile> images = [];

  Future<void> _save() async {
    if (widget.multiple) {
      navPop(images);
    } else {
      loading();
      final XFile file = await _controller!.takePicture();
      navPop();
      await delay(50);
      navPop(file);
    }
  }

  Future<void> _takeImage() async {
    loading();
    final XFile file = await _controller!.takePicture();
    final imageFile = File(file.path);

    // Fix orientation
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    final corrected = img.bakeOrientation(originalImage!);
    await imageFile.writeAsBytes(img.encodeJpg(corrected));

    images.add(XFile(imageFile.path));
    navPop();
    setState(() {});
  }

  void _handleZoom(double scale) {
    final factor = scale > 1 ? 0.07 : 0.2;
    _currentZoomLevel += scale > 1 ? (scale * factor) : -(scale * factor);
    _currentZoomLevel = _currentZoomLevel.clamp(_minZoomLevel, _maxZoomLevel);
    _controller?.setZoomLevel(_currentZoomLevel);
    setState(() {});
  }

  Future<void> _toggleCamera() async {
    final cameras = await availableCameras();
    final currentIndex = cameras.indexWhere(
      (c) => c == _controller?.description,
    );
    final nextCamera = cameras[(currentIndex + 1) % cameras.length];
    await _controller?.dispose();
    _controller = CameraController(nextCamera, ResolutionPreset.high);
    await _controller?.initialize();
    _controller!.getMaxZoomLevel().then((val) {
      if (val < 8) {
        _maxZoomLevel = val;
      } else {
        _maxZoomLevel = 9;
      }
    });
    _controller!.getMinZoomLevel().then((val) {
      _minZoomLevel = val;
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) async {
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      _controller!.getMaxZoomLevel().then((val) {
        if (val < 8) {
          _maxZoomLevel = val;
        } else {
          _maxZoomLevel = 9;
        }
      });
      _controller!.getMinZoomLevel().then((val) {
        _minZoomLevel = val;
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _) => _controller?.dispose(),
      child: Scaffold(
        body: AnnotatedRegion(
          value: AppSystemUi.light(),
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                // Camera Preview
                SizedBox(
                  width: 1.sw,
                  height: 1.sh,
                  child: _controller == null
                      ? const SizedBox()
                      : GestureDetector(
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            _handleZoom(details.scale);
                          },
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                ),

                // Back button
                PositionedDirectional(
                  top: .08.sh,
                  start: .03.sw,
                  child: CircleAvatar(
                    backgroundColor: context.colors.surfaceContainerHighest
                        .withValues(alpha: 0.3),
                    child: BackButton(
                      color: context.colors.primary,
                      onPressed: () {
                        _controller?.dispose();
                        navPop();
                      },
                    ),
                  ),
                ),

                // Bottom controls
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Image previews
                      if (images.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: .03.sw),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: .02.sw,
                              children: List.generate(images.length, (index) {
                                return InkWell(
                                  onTap: () => navP(
                                    ImagesPreviewWidget(
                                      images: images,
                                      index: index,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: .14.sw,
                                        height: .10.sh,
                                        child: Image.file(
                                          File(images[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: 0,
                                        start: 0,
                                        child: InkWell(
                                          onTap: () {
                                            images.removeAt(index);
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: context.colors.error,
                                            size: .04.sw,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      SizedBox(height: .005.sh),

                      // Controls
                      SafeArea(
                        top: false,
                        bottom: true,
                        child: Container(
                          color: context.colors.surfaceContainerHighest
                              .withValues(alpha: 0.5),
                          padding: EdgeInsets.symmetric(
                            horizontal: .05.sw,
                            vertical: .00.sh,
                          ).add(EdgeInsets.only(bottom: .01.sh)),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Toggle Camera
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: _toggleCamera,
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        color: context.colors.onSurface,
                                        size: Constants.isTablet ? 40 : 24,
                                      ),
                                    ),
                                    Text(
                                      LanguageProvider.translate(
                                        'image_picker',
                                        'change_camera',
                                      ),
                                      style: context.text.bodySmall!.copyWith(
                                        color: context.colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),

                                // Add image button
                                if (widget.multiple)
                                  IconButton(
                                    onPressed: _takeImage,
                                    icon: Icon(
                                      Icons.add,
                                      color: context.colors.primary,
                                      size: .08.sw,
                                    ),
                                  ),

                                // Save button
                                ((widget.multiple && images.isNotEmpty) ||
                                        !widget.multiple)
                                    ? ButtonWidget(
                                        onTap: _save,
                                        text: 'save',
                                        width: .20.sw,
                                        height: .045.sh,
                                        color: context.colors.primary,
                                        textStyle: context.text.bodyMedium!
                                            .copyWith(
                                              color: context.colors.onPrimary,
                                            ),
                                        borderRadius: 25,
                                      )
                                    : SizedBox(width: .20.sw),
                              ],
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
        ),
      ),
    );
  }
}

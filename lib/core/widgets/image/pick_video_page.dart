import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper_function/navigation.dart';
import '../../../features/language/presentation/provider/language_provider.dart';
import '../../Theme/app_system_ui.dart';
import '../../constants/constants.dart';
import '../../helper_function/convert.dart';
import '../../helper_function/helper_function.dart';
import '../button_widget.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  CameraController? _controller;
  int record = 0; // 0=init,1=record,2=paused,3=finished
  int sec = 0;
  late int minute;
  double _currentZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    minute = 1;
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.veryHigh);
    await _controller!.initialize();
    _maxZoomLevel = await _controller!.getMaxZoomLevel().then(
      (v) => v < 8 ? v : 9,
    );
    _minZoomLevel = await _controller!.getMinZoomLevel();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  void _toggleCamera() async {
    final cameras = await availableCameras();
    final currentIndex = cameras.indexWhere(
      (c) => c == _controller?.description,
    );
    final nextIndex = (currentIndex + 1) % cameras.length;
    await _controller?.dispose();
    _controller = CameraController(
      cameras[nextIndex],
      ResolutionPreset.veryHigh,
    );
    await _controller!.initialize();
    _maxZoomLevel = await _controller!.getMaxZoomLevel().then(
      (v) => v < 8 ? v : 9,
    );
    _minZoomLevel = await _controller!.getMinZoomLevel();
    if (mounted) setState(() {});
  }

  void _handleZoom(double scale) {
    num factor = scale > 1
        ? 0.07
        : scale < 0.4
        ? 0.7
        : 0.2;
    setState(() {
      _currentZoomLevel = scale > 1
          ? (_currentZoomLevel + (scale * factor)).clamp(
              _minZoomLevel,
              _maxZoomLevel,
            )
          : (_currentZoomLevel - (scale * factor)).clamp(
              _minZoomLevel,
              _maxZoomLevel,
            );
      _controller?.setZoomLevel(_currentZoomLevel);
    });
  }

  void _startRecording() {
    _controller?.startVideoRecording().then((_) {
      record = 1;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (sec < minute * 60) {
          if (mounted) setState(() => sec++);
        } else {
          _pause();
          record = 3;
        }
      });
      setState(() {});
    });
  }

  void _pause() {
    _timer?.cancel();
    _controller?.pauseVideoRecording().then((_) => setState(() {}));
  }

  void _resume() {
    _controller?.resumeVideoRecording().then((_) {
      record = 1;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (sec < minute * 60) {
          if (mounted) setState(() => sec++);
        } else {
          _pause();
          record = 3;
        }
      });
      setState(() {});
    });
  }

  void _send() {
    _timer?.cancel();
    _controller?.stopVideoRecording().then((file) async {
      await delay(100);
      navPop(file);
    });
  }

  void _reset() {
    if (record != 0) {
      _timer?.cancel();
      _controller?.stopVideoRecording().then((_) {
        record = 0;
        sec = 0;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, val) {
        _controller?.dispose();
        _timer?.cancel();
      },
      child: Scaffold(
        body: AnnotatedRegion(
          value: AppSystemUi.light(),
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                // Camera preview
                SizedBox(
                  width: 1.sw,
                  height: 1.sh,
                  child: _controller == null
                      ? const SizedBox()
                      : GestureDetector(
                          onScaleUpdate: (details) =>
                              _handleZoom(details.scale),
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                ),
                // Back button
                PositionedDirectional(
                  top: 0.08.sh,
                  start: 0.03.sw,
                  child: Container(
                    margin: EdgeInsets.all(0.015.sw),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: BackButton(
                      color: colors.primary,
                      onPressed: () {
                        _controller?.dispose();
                        navPop();
                      },
                    ),
                  ),
                ),
                // Timer overlay
                Positioned(
                  top: 6.h,
                  left: 5.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.008.sh,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 0.02.sw),
                        Text(
                          '$minute:00 / ${convertSecToMin(sec)}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom controls
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Row(
                      children: [
                        if (record == 0)
                          InkWell(
                            onTap: _toggleCamera,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_enhance_sharp,
                                  color: colors.onPrimary,
                                  size: Constants.isTablet ? 40 : 20,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  LanguageProvider.translate(
                                    'image_picker',
                                    'change_camera',
                                  ),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colors.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),
                        if ([0, 2].contains(record))
                          InkWell(
                            onTap: () =>
                                record == 0 ? _startRecording() : _resume(),
                            child: Icon(
                              Icons.play_circle,
                              color: colors.onPrimary,
                              size: 40,
                            ),
                          ),
                        if ([1].contains(record))
                          InkWell(
                            onTap: _pause,
                            child: Icon(
                              Icons.pause_circle,
                              color: colors.onPrimary,
                              size: 40,
                            ),
                          ),
                        if ([1, 2, 3].contains(record))
                          InkWell(
                            onTap: _reset,
                            child: Icon(
                              Icons.stop_circle_rounded,
                              color: colors.onPrimary,
                              size: 40,
                            ),
                          ),
                        if ([1, 2, 3].contains(record))
                          ButtonWidget(
                            onTap: _send,
                            text: 'send',
                            width: 0.2.sw,
                            height: 0.045.sh,
                            color: colors.onPrimary,
                            textStyle: textTheme.bodySmall?.copyWith(
                              color: colors.primary,
                            ),
                            borderRadius: 25,
                          ),
                      ],
                    ),
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

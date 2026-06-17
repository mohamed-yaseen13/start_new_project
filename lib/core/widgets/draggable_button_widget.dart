import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../Theme/app_theme.dart';
import '../helper_function/helper_function.dart'; // make sure ThemeX is imported

class DraggableImageButton extends StatefulWidget {
  const DraggableImageButton({
    super.key,
    required this.onComplete,
    required this.text,
  });

  final String text;
  final VoidCallback onComplete;

  @override
  State<DraggableImageButton> createState() => _DraggableImageButtonState();
}

class _DraggableImageButtonState extends State<DraggableImageButton> {
  double posX = 20;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors; // Theme-aware colors
    final textTheme = context.text; // Theme-aware text

    final screenWidth = MediaQuery.of(context).size.width;
    final maxX =
        screenWidth - 100; // adjust if needed for draggable button width

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            width: .90.sw,
            height: .06.sh,
            decoration: BoxDecoration(
              color: completed
                  ? colors.primary
                  : colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              LanguageProvider.translate("buttons", widget.text),
              style: textTheme.bodyMedium?.copyWith(
                color: completed ? colors.onPrimary : colors.onSurface,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PositionedDirectional(
            start: posX,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (LanguageProvider.isAr()) {
                  posX -= details.delta.dx; // MINUS instead of PLUS
                } else {
                  posX += details.delta.dx;
                }
                if (posX < 20) posX = 20;
                if (posX > maxX) posX = maxX;
                completed = posX >= maxX; // COMPLETE when reaching RIGHT side
                if (posX < maxX - 20) completed = false;
                setState(() {});
              },
              onHorizontalDragEnd: (details) async {
                await delay(100);
                if (completed) widget.onComplete();
                await delay(500);
                setState(() {
                  posX = 20;
                  completed = false;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: .03.sw,
                    vertical: .005.sh,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    completed ? Icons.check : Icons.arrow_forward_ios,
                    key: ValueKey(completed),
                    size: 18.sp,
                    color: completed ? colors.primary : colors.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

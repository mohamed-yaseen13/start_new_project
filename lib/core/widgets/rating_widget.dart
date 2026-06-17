import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import '../Theme/app_theme.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    this.onRate,
    this.read = false,
    this.rate = 5,
    this.showText = true,
    this.iconSize,
  });
  final void Function(double rate)? onRate;
  final bool read, showText;
  final double rate;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showText)
          Text(
            '($rate)',
            style: context.text.bodySmall!.copyWith(
              color: const Color(0xffFFBF1C),
            ),
          ),
        if (showText) SizedBox(width: .01.sw),
        Directionality(
          textDirection: TextDirection.ltr,
          child: SimpleStarRating(
            allowHalfRating: true,
            nonFilledIcon: Icon(
              Icons.star,
              color: Color(0xffBFBFBF),
              size: (iconSize ?? 11),
            ),
            starCount: 5,
            rating: rate,
            size: iconSize ?? 11,
            isReadOnly: read,
            onRated: (rate) {
              if (onRate != null) {
                onRate!(rate ?? 0);
              }
            },
            spacing: 2,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class RatingItemWidget extends StatelessWidget {
  const RatingItemWidget({super.key, this.onRate,this.read = false, this.rate = 5, this.showText = true, this.iconSize, this.nonFilledColor});
  final void Function(double rate)? onRate;
  final bool read,showText;
  final double rate;
  final double? iconSize;
  final Color?nonFilledColor;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SimpleStarRating(
        allowHalfRating: true,
        starCount: 5,filledIcon: Icon(Icons.star,color: const Color(0xffFFBB00),size: iconSize,),
        nonFilledIcon: Icon(Icons.star,color:nonFilledColor?? Colors.grey.shade300,size: iconSize,),
        rating: rate,
        size: iconSize??11,
        isReadOnly: read,
        onRated: (rate) {
          if(onRate!=null){
            onRate!(rate??0);
          }
        },
        spacing: 2,
      ),
    );
  }
}
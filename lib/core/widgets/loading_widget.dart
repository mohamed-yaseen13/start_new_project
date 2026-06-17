import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .02.sh,horizontal: .02.sw),
      child: Center(
        child: Transform.scale(scale: 2,
            child:   CupertinoActivityIndicator(color: Colors.black,radius: .025.sw,)),
      ),
    );
  }
}

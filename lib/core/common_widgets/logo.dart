import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/logo.png",
          width: ScreenUtil.getInstance().setWidth(110),
          height: ScreenUtil.getInstance().setHeight(110),
        ),
        Text("LOGO",
            style: TextStyle(
                fontFamily: "Poppins-Bold",
                fontSize: ScreenUtil.getInstance().setSp(46),
                letterSpacing: .6,
                fontWeight: FontWeight.bold))
      ],
    );
  }
}

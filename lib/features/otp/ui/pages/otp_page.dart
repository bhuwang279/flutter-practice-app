import 'package:flutter/material.dart';
import 'package:recharge_app/core/common_widgets/logo.dart';
import '../../../../core/common_widgets/illustrations.dart';
import '../Widgets/EnterOTPFormCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../UIData.dart';
class OTPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Illustraion(UIData.OTPTopIllustraion, UIData.OTPBottomIllustraion),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Logo(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  OPTFormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
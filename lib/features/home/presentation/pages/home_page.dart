import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/bottom_navigation.dart';
import '../../../../core/common_widgets/logo.dart';
import '../../../UIData.dart';
import '../../providers/login_provider.dart';
import '../Widgets/RechargeFormCard.dart';
enum LoginValidationType { phone, otp }
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

    final scaffoldState = GlobalKey<ScaffoldState>();
  Widget loginScaffold() => LoginProvider(
        validationErrorCallback: showValidationError,
        child: Scaffold(
          key: scaffoldState,
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Illustraion(UIData.loginTopIllustraion, UIData.loginBottomIllustraion),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
                  child: Column(
                    children: <Widget>[
                      Logo(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
                      RechargeFormCard(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      
                          InkWell(
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(330),
                              height: ScreenUtil.getInstance().setHeight(100),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'payment_page');
                                  },
                                  child: Center(
                                    child: Text("Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        ),
      );

  showValidationError(LoginValidationType type) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(type == LoginValidationType.phone
          ? UIData.enter_valid_number
          : UIData.enter_valid_otp),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return loginScaffold();
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_app/core/common_widgets/loading.dart';
import 'package:recharge_app/core/common_widgets/logo.dart';
import 'package:recharge_app/core/common_widgets/messge_display.dart';
import 'package:recharge_app/core/common_widgets/sign_up.dart';
import 'package:recharge_app/features/login/presentation/bloc/bloc.dart';
import 'package:recharge_app/features/login/presentation/bloc/login_bloc.dart';
import '../../../../injection_container.dart';
import '../../../../core/common_widgets/illustrations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/LoginFormCard.dart';
import '../../../UIData.dart';

enum LoginValidationType { phone, otp }

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: buildBody(context),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<LoginBloc>(),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Illustraion(
              UIData.loginTopIllustraion, UIData.loginBottomIllustraion),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Logo(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LoginInitial) {
                      return Container();
                    } else if (state is LoginLoading) {
                      return LoadingWidget();
                    } else if (state is LoggedIn) {
                      return MessageDisplay(message: 'Logged In');
                    } else if (state is LoginFailure) {
                      print(state.error);
                      return MessageDisplay(message: state.error);
                    }
                  }),
                  LoginFormCard(),
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
                                Color(0xFF38ef7d),
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
                                Navigator.pushNamed(context, 'recharge_page');
                              },
                              child: Center(
                                child: Text("SIGNIN",
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
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SignUpBlock()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

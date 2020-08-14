import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_app/core/bloc_helpers/bloc_provider.dart';
import 'package:recharge_app/core/bloc_widgets/bloc_state_builder.dart';
import 'package:recharge_app/core/blocs/authentication/authentication_bloc.dart';
import 'package:recharge_app/core/blocs/authentication/authentication_state.dart';
import 'package:recharge_app/core/common_widgets/illustrations.dart';
import 'package:recharge_app/core/common_widgets/logo.dart';
import 'package:recharge_app/core/common_widgets/pending_action.dart';
import 'package:recharge_app/core/common_widgets/sign_up.dart';
import 'package:recharge_app/features/login/presentation/Widgets/LoginFormCard.dart';

import '../../../UIData.dart';

class LoginPage extends StatelessWidget {
  /// Prevent Use of back button
  ///

  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: buildBody(bloc),
        ),
      ),
    );
  }

  Container buildBody(AuthenticationBloc bloc) {
    return Container(
      child: BlocEventStateBuilder<AuthenticationState>(
          bloc: bloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state.isAuthenticating) {
              return PendingAction();
            }

            if (state.isAuthenticated) {
              return Container();
            }
            List<Widget> children = <Widget>[
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
        ];

        return Stack(
          fit: StackFit.expand,
          children: children,
        );
            
          }),
    );
  }
}

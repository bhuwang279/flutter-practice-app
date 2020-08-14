import 'package:flutter/material.dart';
import 'package:recharge_app/features/home/presentation/pages/home_page.dart';
import 'package:recharge_app/features/payment/presentation/pages/payment.dart';

import 'core/bloc_helpers/bloc_provider.dart';
import 'core/blocs/authentication/authentication_bloc.dart';
import 'core/common_widgets/slide_right_route.dart';
import 'core/pages/decision_page.dart';
import 'core/pages/initialization_page.dart';
import 'features/forgot_password/ui/pages/forgot_password_page.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/otp/ui/pages/otp_page.dart';

class RechargeApp extends StatelessWidget {
  
    @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
     
        child: MaterialApp(
          title: 'Daza E-Load',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/decision': (BuildContext context) => DecisionPage(),
            
          },
          home: InitializationPage(),
        ),
  
    );
  }
// }
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Recharge App',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new LoginPage(),
//       onGenerateRoute: (RouteSettings settings) {
//         switch(settings.name) {
//           case "login":
//             return SlideRightRoute(widget: LoginPage());
//             break;
//           case "recover":
//             return SlideRightRoute(widget: ForgotPasswordPage());
//             break;
//           case "enter_otp":
//             return SlideRightRoute(widget: OTPPage());
//             break;
//           case 'recharge_page':
//             return SlideRightRoute(widget: HomePage());
//             break;
//           case 'payment_page':
//           return SlideRightRoute(widget: PaymentSuccessPage());
//           default:
//             return null;
//         }
//       }
//     );
//   }
}
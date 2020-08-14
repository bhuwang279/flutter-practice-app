// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:recharge_app/core/bloc_helpers/bloc_provider.dart';
// import 'package:recharge_app/core/bloc_widgets/bloc_state_builder.dart';
// import 'package:recharge_app/core/common_widgets/pending_action.dart';
// import 'package:recharge_app/features/login/domain/usecases/get_mobile_number_and_token.dart';
// import 'package:recharge_app/features/login/presentation/bloc/authentication/authentication_bloc.dart';

// import 'package:recharge_app/features/login/presentation/bloc/authentication/authentication_state.dart';


// import 'package:recharge_app/features/login/presentation/bloc/login_bloc.dart';
// import 'package:recharge_app/features/login/presentation/bloc/login_event.dart';
// import 'package:recharge_app/features/login/presentation/bloc/login_form_bloc.dart';

// class LoginFormCard extends StatefulWidget {

//   @override
//   State<LoginFormCard> createState() => _LoginFormState();
// }


// class _LoginFormState extends State<LoginFormCard>{
//   TextEditingController _mobileNumberController;
//   TextEditingController _passwordController;
//   LoginFormBloc _loginFormBloc;
 

//   @override
//   void initState() {
//     super.initState();
//     _mobileNumberController = TextEditingController();
//     _passwordController = TextEditingController();
//     _loginFormBloc = LoginFormBloc();

    
//   }

//   @override
//   void dispose() {
//     _loginFormBloc?.dispose();
//     _mobileNumberController?.dispose();
//     _passwordController?.dispose();
   

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context){
//     AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
//     return BlocEventStateBuilder<AuthenticationState>(
//       bloc:bloc,
//       builder: (BuildContext context, AuthenticationState state){
//         if (state.isAuthenticating){
//           return PendingAction();
//         }else if(state.isAuthenticated){
//           print('success');
//         }else if (state.hasFailed){
//           print(state.error);
//         }
//       },

//     );
//   }

//   @override
//   Widget build(BuildContext context) {
     
//     return new Container(
//       width: double.infinity,
//       height: ScreenUtil.getInstance().setHeight(500),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0.0, 15.0),
//                 blurRadius: 15.0),
//             BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0.0, -10.0),
//                 blurRadius: 10.0),
//           ]),
//       child: Padding(
//         padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("Login",
//                 style: TextStyle(
//                     fontSize: ScreenUtil.getInstance().setSp(45),
//                     fontFamily: "Poppins-Bold",
//                     letterSpacing: .6)),
//             SizedBox(
//               height: ScreenUtil.getInstance().setHeight(30),
//             ),
//             Text("Mobile Number",
//                 style: TextStyle(
//                     fontFamily: "Poppins-Medium",
//                     fontSize: ScreenUtil.getInstance().setSp(26))),
//             TextField(
//               controller: _mobileNumberController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   hintText: "Enter 8 digit Mobile Number",
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
//               onChanged: (value) {
//                 mobileNumber = value;
//           },
//             ),
//             SizedBox(
//               height: ScreenUtil.getInstance().setHeight(30),
//             ),
//             Text("PassWord",
//                 style: TextStyle(
//                     fontFamily: "Poppins-Medium",
//                     fontSize: ScreenUtil.getInstance().setSp(26))),
//             TextField(
//               obscureText: true,
//               controller: _passwordController,
//               decoration: InputDecoration(
//                   hintText: "Password",
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
//               onChanged: (value) {
//                 password = value;
//           },
//             ),
//             SizedBox(
//               height: ScreenUtil.getInstance().setHeight(35),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 GestureDetector(
//                       child: Text(
//                         "Forgot Password?",
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontFamily: "Poppins-Medium",
//                             fontSize: ScreenUtil.getInstance().setSp(28)),
//                       ),
//                       onTap: dispatchMobileNumberPassword
//                     ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//    void dispatchMobileNumberPassword() {
//     // Clearing the TextField to prepare it for the next inputted number
//     _mobileNumberController.clear();
//     _passwordController.clear();
    
//     BlocProvider.of<LoginBloc>(context)
//         .add(LoginButtonPressed(mobileNumber: mobileNumber, password: password));
//   }
// }

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_app/core/bloc_helpers/bloc_provider.dart';
import 'package:recharge_app/core/bloc_widgets/bloc_state_builder.dart';
import 'package:recharge_app/core/common_widgets/pending_action.dart';
import 'package:recharge_app/features/login/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:recharge_app/features/login/presentation/bloc/authentication/authentication_event.dart';

import 'package:recharge_app/features/login/presentation/bloc/authentication/authentication_state.dart';
import 'package:recharge_app/features/login/presentation/bloc/login_form_bloc.dart';

class LoginFormCard extends StatefulWidget {

  @override
  State<LoginFormCard> createState() => _LoginFormState();
}


class _LoginFormState extends State<LoginFormCard>{
  TextEditingController _mobileNumberController;
  TextEditingController _passwordController;
  LoginFormBloc _loginFormBloc;
 

  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _loginFormBloc = LoginFormBloc();

    
  }

  @override
  void dispose() {
    _loginFormBloc?.dispose();
    _mobileNumberController?.dispose();
    _passwordController?.dispose();
   

    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
      bloc:bloc,
      builder: (BuildContext context, AuthenticationState state){
        if (state.isAuthenticating){
          return PendingAction();
        }else if(state.isAuthenticated){
          return _buildSuccess();
        }else if (state.hasFailed){
         return  _buildFailure(state.error);
         
        }

        return _buildForm(bloc);
      },

    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Text('Success'),
    );
  }

  Widget _buildFailure(String error) {
    return Center(
      child: Text('Failure'),
    );
  }

  Widget _buildForm(AuthenticationBloc bloc) {
    return Form(
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
              stream: _loginFormBloc.mobileNumber,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    errorText: snapshot.error,
                  ),
                  controller: _mobileNumberController,
                  onChanged: _loginFormBloc.onMobileNumberChange,
                  keyboardType: TextInputType.emailAddress,
                );
              }),
          StreamBuilder<String>(
              stream: _loginFormBloc.password,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'password',
                    errorText: snapshot.error,
                  ),
                  controller: _passwordController,
                  obscureText: false,
                  onChanged: _loginFormBloc.onPasswordChange,
                );
              }),
         
          StreamBuilder<bool>(
              stream:_loginFormBloc.loginValid,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return RaisedButton(
                  child: Text('Login'),
                  onPressed: (snapshot.hasData && snapshot.data == true)
                      ? () {
                          bloc.emitEvent(AuthenticationEventLogin(
                            mobileNumber: _mobileNumberController.text,
                            password: _passwordController.text
                          ));
                        
                        }
                      : null,
                );
              }),
        ],
      ),
    );
  }
 
}

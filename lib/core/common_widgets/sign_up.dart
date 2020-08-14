import 'package:flutter/material.dart';

class SignUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "New User? ",
          style: TextStyle(fontFamily: "Poppins-Medium"),
        ),
        InkWell(
          onTap: () {},
          child: Text("SignUp",
              style: TextStyle(
                  color: Color(0xFF5d74e3), fontFamily: "Poppins-Bold")),
        )
      ],
    );
  }
}

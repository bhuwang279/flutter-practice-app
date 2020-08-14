import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/bottom_navigation.dart';
import '../../../../core/common_widgets/logo.dart';
import '../widgets/PaymentDetailFormCard.dart';
import '../widgets/payment_status_header.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  PaymentSuccessPageState createState() {
    return new PaymentSuccessPageState();
  }
}

class PaymentSuccessPageState extends State<PaymentSuccessPage> {
  bool isDataAvailable = true;
  Widget bodyData() => Center(
        child: isDataAvailable
            ?  Row(
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
                                  onTap: () =>showSuccessDialog(),
                    
                                  child: Center(
                                    child: Text("Process",
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
                      )
            : CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      PaymentDetailFormCard(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                      bodyData()

                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        );
  }

  void showSuccessDialog() {
    setState(() {
      isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
    });
  }

  goToDialog() {
    setState(() {
      isDataAvailable = true;
    });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    successTicket(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  successTicket() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PaymentStatusHeader(
                  title: "Thank You!",
                  textColor: Colors.purple,
                  subtitle: "Your transaction was successful",
                ),
                ListTile(
                  title: Text("Date"),
                  subtitle: Text("26 June 2018"),
                  trailing: Text("11:00 AM"),
                ),
                ListTile(
                  title: Text("Mobile Number"),
                  subtitle: Text("77880794"),
                  trailing: Text('BT'),
                ),
                ListTile(
                  title: Text("Amount"),
                  subtitle: Text("Nu 50"),
                  trailing: Text("Completed"),
                ),
              ],
            ),
          ),
        ),
      );
}

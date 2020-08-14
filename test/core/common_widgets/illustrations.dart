import 'package:flutter/material.dart';

class Illustraion extends StatefulWidget {
  final String topIllustration;
  final String bottomIllustration;

  Illustraion(this.topIllustration, this.bottomIllustration);
  @override
  _IllustrationState createState() => new _IllustrationState(topIllustration, bottomIllustration);
}

class _IllustrationState extends State<Illustraion> {
  var topIllustration;
  var bottomIllustration;

  _IllustrationState(this.topIllustration, this.bottomIllustration);
  @override
  Widget build(BuildContext context) {
    
    return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset(widget.topIllustration),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset(widget.bottomIllustration)
            ],
          );
  }
  
}
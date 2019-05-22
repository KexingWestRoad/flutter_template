import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              child: new Image(
                image: AssetImage('assets/images/launch.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              )
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    countDown();
  }
  void countDown() {
    print("倒计时");
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration,go2TabPage);
  }
  void go2TabPage() {
    print("跳转首页");
    Navigator.pushReplacementNamed(context, '/TabBarPage');
  }
}
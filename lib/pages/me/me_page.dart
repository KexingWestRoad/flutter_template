import 'package:flutter/material.dart';

class MePage extends StatefulWidget {

  MePage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
    );
  }
}
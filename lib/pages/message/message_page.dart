import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {

  MessagePage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
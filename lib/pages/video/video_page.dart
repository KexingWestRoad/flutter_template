import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {

  VideoPage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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
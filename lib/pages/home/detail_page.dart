import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget {
  final Todo todo;
  DetailPage({Key key, @required this.todo}) : super(key: key);

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${todo.title}"),
      ),
      body: new Center(
        child: new GestureDetector(
          child: new Text("${todo.description}"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;
  Todo(this.title, this.description);
}

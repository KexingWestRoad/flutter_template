import 'package:flutter/material.dart';
import '../home/detail_page.dart';

final todos = new List<Todo>.generate(
    20,
        (i) => new Todo(
        "Todo $i", "A description of what needs to be done for Todo $i"));

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = List.generate(10, (index) => "This is number $index");

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: getBody(),
      ),
    );
  }
  getBody() {
    return ListView.builder(
      itemCount: list.length, 
      itemBuilder: (BuildContext context, int index) {
        return getItem(index,list[index]);
      });
  }
  getItem(int index, String title) {
    //return new Text(title);
    return new Card(
      child: new FlatButton(
        onPressed: () => _routerVC(index),
        child: new ListTile(
          title: new Text(index.toString()),
          subtitle: new Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
      ),
    );
  }
  _routerVC(int index) {
    print('点击:${index.toString()}');
    print(todos[index]);
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => 
        new DetailPage(todo: todos[index],)
      )
    );
  }
}
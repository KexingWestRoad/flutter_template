import 'package:flutter/material.dart';
import '../home/detail_page.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list;
  List<Todo> todos;
  ScrollController _controller;

@override
void initState() {
  super.initState();
  list = List.generate(10, (index) => "This is number $index");
  todos = List<Todo>.generate(list.length, (index) => new Todo("Todo $index", "A description of what needs to be done for Todo $index"));
  _controller = ScrollController();
  _controller.addListener(() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData();
    }
  });
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

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
  Widget getBody() {
    return new RefreshIndicator(
      onRefresh: _refresh,
      color: Colors.blue,
      child: ListView.builder(
        controller: _controller,
        itemCount: list.length + 1, 
        itemBuilder: (BuildContext context, int index) {
          if (index == list.length) {
            print("展示上拉加载更多进度");
            return loadMoreProgressIndicator();
          } else {
            return getItem(index,list[index]);
          }
        },
      ),
    );
  }
  Widget getItem(int index, String title) {
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
    
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => 
        new DetailPage(todo: todos[index],)
      )
    );
  }
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.clear();
        list = List.generate(10, (index) => "This is number $index");
        todos = List<Todo>.generate(list.length, (index) => new Todo("Todo $index", "A description of what needs to be done for Todo $index"));
        return;
      });
    });
  }
  Future _getMoreData() async {
    print("获取更多数据");
    await Future.delayed(Duration(seconds: 2),() {
      setState(() {
        List<String> moreData = List.generate(5, (index) => "add data $index");
        list.addAll(moreData);
        todos = List<Todo>.generate(list.length, (index) => new Todo("Todo $index", "A description of what needs to be done for Todo $index"));
      });
    });
  }
  Widget loadMoreProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(30.0),
      child: new Center(
        child: new Opacity(
          opacity: 1.0,
          child: new CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_template/components/color_circle_loader.dart';
import 'package:flutter_template/components/dot_type.dart';
import 'package:flutter_template/pages/home/detail_page.dart';
import 'package:flutter_template/components/color_dot_loader.dart';
import 'package:flutter_template/pages/home/home_navbar.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list;
  List<Item>tools;
  List<Todo> todos;
  ScrollController _controller;

@override
void initState() {
  tools = <Item>[
    Item(0xe60e, '重启', 'Restart.Home'),
    Item(0xe60f, '日志清理', 'ServerLogs.Home'),
    Item(0xe641, 'Dump', 'Dump.Home'),
    Item(0xe641, '机器置换', 'ReplaceHost.Index'),
    Item(0xe606, '全部', ''),
  ];
  list = List.generate(10, (index) => "This is number $index");
  todos = List<Todo>.generate(list.length, (index) => new Todo("Todo $index", "A description of what needs to be done for Todo $index"));
  _controller = ScrollController();
  _controller.addListener(() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData();
    }
  });
  super.initState();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeNavBar(title: '首页',items: tools),
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
    await Future.delayed(Duration(seconds: 2),() {
      setState(() {
        List<String> moreData = List.generate(5, (index) => "add data $index");
        list.addAll(moreData);
        todos = List<Todo>.generate(list.length, (index) => new Todo("Todo $index", "A description of what needs to be done for Todo $index"));
      });
    });
  }

  /*
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
  */

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];

  Widget loadMoreProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(10),
      child: new Center(
        child: ColorCircleLoader(colors: colors, duration: Duration(seconds: 10)),
      ),
    );
  }

  Widget colorDotLoaderIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(10),
      child: new Center(
        child: ColorDotLoader(
          dotOneColor: Colors.redAccent,
          dotTwoColor: Colors.blueAccent,
          dotThreeColor: Colors.green,
          dotType: DotType.circle,
          dotIcon: Icon(Icons.adjust),
          duration: Duration(seconds: 3),
        ),
      ),
    ); 
  }
}
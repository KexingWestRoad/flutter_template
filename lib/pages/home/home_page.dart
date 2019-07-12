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
  List<Item> tools;
  List<Todo> todos;
  ScrollController _controller;

  @override
  void initState() {
    tools = <Item>[
      Item(0xe60e, '操作1', 'Restart.Home'),
      Item(0xe60f, '操作2', 'ServerLogs.Home'),
      Item(0xe641, '操作3', 'Dump.Home'),
      Item(0xe641, '操作4', 'ReplaceHost.Index'),
      Item(0xe606, '全部', ''),
    ];
    list = List.generate(10, (index) => "This is number $index");
    todos = List<Todo>.generate(
        list.length,
        (index) => new Todo("Todo $index",
            "A description of what needs to be done for Todo $index"));
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
      appBar: HomeNavBar(title: '首页', items: tools),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xEFF1F3),
        ),
        //child: getBody(),
        child: buildAppListView(context, tools),
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
            return getItem(index, list[index]);
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
            builder: (context) => new DetailPage(
                  todo: todos[index],
                )));
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.clear();
        list = List.generate(10, (index) => "This is number $index");
        todos = List<Todo>.generate(
            list.length,
            (index) => new Todo("Todo $index",
                "A description of what needs to be done for Todo $index"));
        return;
      });
    });
  }

  Future _getMoreData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        List<String> moreData = List.generate(5, (index) => "add data $index");
        list.addAll(moreData);
        todos = List<Todo>.generate(
            list.length,
            (index) => new Todo("Todo $index",
                "A description of what needs to be done for Todo $index"));
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
        child:
            ColorCircleLoader(colors: colors, duration: Duration(seconds: 10)),
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

Widget buildAppListView(BuildContext context, List<Item> items) {
  return CustomScrollView(
    slivers: <Widget>[
      headerView('HeaderView1'),
      SliverToBoxAdapter(
        child: Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items.map((item) {
              return buildAppView(context, item);
            }).toList(),
          ),
        ),
      ),
      headerView('HeaderView2'),
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items.map((item) {
              return buildFolderView(context, item);
            }).toList(),
          ),
        ),
      ),
      headerView('HeaderView3'),
      SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        children: items.map((item) {
          return buildScreenView(context, item);
        }).toList(),
      )
    ],
  );
}

Widget headerView(String title) {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 10, 12, 10),
      height: 44.0,
      color: Colors.transparent,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    ),
  );
}

Widget buildFolderView(BuildContext context, Item item) {
  final screenSize = MediaQuery.of(context).size;
  final folderWidth = (screenSize.width - 42) / 3.0;
  final folderHeight = folderWidth / 1.4;
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.only(top: 10, left: 10, bottom: 15),
    child: Container(
      width: folderWidth,
      height: folderHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6.0),
            color: Color(0x401B2B42),
            blurRadius: 8,
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/pic_card_favorite.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () => routerVC(context),
        child: Text(
          '文件夹${item.title}',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget buildAppView(BuildContext context, Item item) {
  return Container(
    color: Colors.transparent,
    width: 183,
    height: 120,
    padding: EdgeInsets.only(top: 10, left: 10, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6.0),
            color: Color(0x401B2B42),
            blurRadius: 8,
          ),
        ],
      ),
      child: Card( 
        child: Center(
          child: Text(
            '${item.title}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget buildScreenView(BuildContext context, Item item) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.only(top: 10, left: 10,right: 10, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6.0),
            color: Color(0x401B2B42),
            blurRadius: 8,
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/pic_card_favorite.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () => routerVC(context),
        child: null,
      ),
    ),
  );
}

routerVC (BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => DetailPage(todo: Todo("Todo",
            "A description of what needs to be done for Todo")),
  ));
}

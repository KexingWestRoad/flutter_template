import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeNavBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Item> items;
  final String title;
  const HomeNavBar({Key key, this.items, this.title}) : super(key: key);
  @override
  _HomeNavBarBarState createState() => _HomeNavBarBarState();
  @override
  Size get preferredSize => const Size.fromHeight(160);
}

class _HomeNavBarBarState extends State<HomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: FlatButton(
                color: Color(0x16FFFFFF),
                onPressed: () {
                  print('搜索框点击点击');
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.only(right: 5.0),
                      child: Icon(
                        IconData(0xe650, fontFamily: 'iconfont'),
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '应用/分组/域名/主机名/IP',
                      style: new TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 68,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildToolItem(context, widget.items[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 导航栏Item
class Item {
  final int icon;
  final String title;
  final String url;

  Item(this.icon, this.title, this.url);
}

Widget buildToolItem(BuildContext context, Item item, int index) {
  final screenSize = MediaQuery.of(context).size;
  return Container(
    width: screenSize.width / 5,
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        print('press$index');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: new EdgeInsets.only(bottom: 5.0),
            child: Icon(
              IconData(item.icon, fontFamily: 'iconfont'),
              color: Colors.white,
            ),
          ),
          Text(item.title,
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
              maxLines: 1),
        ],
      ),
    ),
  );
}

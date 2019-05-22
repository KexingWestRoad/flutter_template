import 'package:flutter/material.dart';

class HomeNavBar extends StatefulWidget implements PreferredSizeWidget{
  final List<Item> items;
  final String title;
  const HomeNavBar({Key key, this.items,this.title}) : super(key: key);
    @override
    _HomeNavBarBarState createState() => _HomeNavBarBarState();

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}

class _HomeNavBarBarState extends State<HomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0), 
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12.0,right: 12.0),
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
                          IconData(0xe650,fontFamily: 'iconfont'),
                            color: Colors.white,
                          ),
                      ),
                      Text('应用/分组/域名/主机名/IP',style: new TextStyle(color: Colors.white),)
                    ],
                  ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.items.map((Item item) {
                  return toolItem(item);
                }).toList(),
              ),
          ],
          )
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

Widget toolItem(Item item) {
  return Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: new EdgeInsets.only(bottom: 5.0),
                  child: Icon(
                    IconData(item.icon,fontFamily: 'iconfont'),
                    color: Colors.white,
                  ),
                ),
                Text(item.title,style: new TextStyle(color: Colors.white),)
              ],
            )
          ),
        );
}

/**
Widget toolButton() {
  return 
}
*/
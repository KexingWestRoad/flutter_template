import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../home/home_page.dart';
import '../video/video_page.dart';
import '../message/message_page.dart';
import '../me/me_page.dart';

class TabBarPage extends StatefulWidget {

  TabBarPage({Key key, this.title}) : super(key: key);
  final String title; 
  
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  final tabbarTitles = ['首页','视频','消息','我的'];
  final tabbarTitleColorSelected = TextStyle(color: const Color(0xff63ca6c));
  final tabbarTitleColorNormal = TextStyle(color: const Color(0xff969696));
  final themeColor = Colors.blue;

  int _currentIndex = 0;
  List<Widget> controllers = List();

  @override
  void initState() {
    controllers
      ..add(HomePage(title: tabbarTitles[0],))
      ..add(VideoPage(title: tabbarTitles[1],))
      ..add(MessagePage(title: tabbarTitles[2],))
      ..add(MePage(title: tabbarTitles[3],));
    
    super.initState();
  }

  Color getIconColor(int index) {
    if (index == _currentIndex) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controllers[_currentIndex],
        bottomNavigationBar: CupertinoTabBar(
          items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: getIconColor(0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note,
              color: getIconColor(1),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: getIconColor(2),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity,
              color: getIconColor(3),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        ),
      );
  }
}
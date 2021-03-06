import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/cigen_tabbar_page.dart';
import 'package:flutter_cigen/page/favorite_list_page.dart';
import 'package:flutter_cigen/page/dict_page.dart';

class BottomBarPage extends StatefulWidget {
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {

  int currentIndex = 0;
  var currentPage;

  //底部导航对应的页面(状态保持的时候，必须返回泛型)
  final List<Widget> bottomPages = [
    CigenTabbarPage(),
    DictPage(),
    FavoriteListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              title: Text('词根词缀'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('英汉词典'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_solid),
              title: Text('生词本'),
            )
          ],
          onTap: (index){
            setState(() {
              currentIndex = index;
              currentPage = bottomPages[currentIndex];
            });
          },
        ),
        body: IndexedStack(
          //状态保持
          index: currentIndex,
          children: bottomPages,
        )
    );
  }
}

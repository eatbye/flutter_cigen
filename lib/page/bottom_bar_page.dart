import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/cigen_tabbar_page.dart';
import 'package:flutter_cigen/page/favorite_list_page.dart';
import 'package:flutter_cigen/page/dict_page.dart';
import 'package:flutter_cigen/page/test_page.dart';

class BottomBarPage extends StatefulWidget {
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {

  int currentIndex = 0;
  var currentPage = 0;

  //底部导航对应的页面(状态保持的时候，必须返回泛型)
  final List<Widget> bottomPages = [
    // CigenTabbarPage(),
    // DictPage(),
    // FavoriteListPage(),
    CigenTabbarPage(),
    DictPage(),
    FavoriteListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            label: '词根词缀',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '英汉词典',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_solid),
            label: '生词本',
          )
        ],
        // onTap: (index){
        //   setState(() {
        //     currentIndex = index;
        //     currentPage = bottomPages[currentIndex];
        //   });
        // },
      ),
      tabBuilder: (BuildContext context, int index) {
        return bottomPages[index];
      },
    );
  }

  /*
  @override
  Widget build2(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: 0,
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
            currentPage = bottomPages[index];
          });
        },
      ),
      // body: IndexedStack(
//        状态保持
        // index: currentIndex,
        // children: bottomPages,
      // )
        body: bottomPages[currentIndex]
    );
  }

   */

  /*
  @override
  Widget build1(BuildContext context) {
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
  */
}

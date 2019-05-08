import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/cigen_list_page.dart';
import 'package:flutter_cigen/page/dict_page.dart';

class CigenTabbarPage extends StatefulWidget {
  @override
  _CigenTabbarPageState createState() => _CigenTabbarPageState();
}

class _CigenTabbarPageState extends State<CigenTabbarPage> {
  final List<Tab> _tabList = [
    Tab(
      text: '前缀',
    ),
    Tab(
      text: '后缀',
    ),
    Tab(
      text: '词根',
    ),
    Tab(
      text: '词缀',
    ),
  ];

  TabController _controller;

  final List<Widget> pages = [
    CigenListPage('1'),
    CigenListPage('2'),
    CigenListPage('3'),
    CigenListPage('4')
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: pages.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('词根词缀'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: Column(
        children: <Widget>[
          Container(
            child: TabBar(
              tabs: _tabList,
              controller: _controller,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
            ),
          ),
          Divider(height: 0,),
          Expanded(
            child: TabBarView(
              children: pages,
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }
}

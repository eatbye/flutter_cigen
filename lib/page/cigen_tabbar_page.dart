import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/cigen_list_page.dart';
import 'package:flutter_cigen/page/dict_page.dart';
import 'package:flutter_cigen/res/colors.dart';

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

  // TabController _controller;

  final List<Widget> pages = [
    CigenListPage('1'),
    CigenListPage('2'),
    CigenListPage('3'),
    CigenListPage('4')
  ];

  @override
  void initState() {
    super.initState();
    // _controller = TabController();
    // _controller = TabController(
    //   length: pages.length,
    //   initialIndex: 0,
    //   vsync: ScrollableState(),
    // );

  }


  Widget build(BuildContext context) {
    var isDart = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      initialIndex: 0,
      length: _tabList.length,
      child: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text('词根词缀'),
            ),
            preferredSize: Size.fromHeight(44.0)),
        body: Column(
          children: [
            TabBar(
              tabs: _tabList,
              labelColor: isDart ? Colors.white : Colors.blue,
              unselectedLabelColor: isDart ? Colours.dark_text  : Colors.black54,
            ),
            Expanded(
              child: TabBarView(
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    var isDart = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('词根词缀'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: buildMain(isDart),
    );
  }

  Widget buildMain(bool isDart) {
    return Column(
      children: [
        Container(
          child: TabBar(
            tabs: _tabList,
          ),
        ),
        Expanded(
          child: TabBarView(
            children: pages,
            // controller: _controller,
          ),
        )
      ],
    );
  }

  /*
  Widget buildMain1(bool isDart) {
    return Column(
      children: <Widget>[
        Container(
          child: TabBar(
            tabs: _tabList,
            controller: _controller,
            indicatorSize: TabBarIndicatorSize.tab,  //下划线宽度
            isScrollable: false,
            labelColor: isDart ? Colors.white : Colors.blue,
            unselectedLabelColor: isDart ? Colours.dark_text  : Colors.black54,
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
    );
  }

   */
}

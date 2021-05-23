import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar Widget'),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: <Widget>[
                Text('测试1', style: TextStyle(color: Colors.black54),),
                Text('测试2'),
                Text('测试3'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: Text('It\'s cloudy here'),
                  ),
                  Center(
                    child: Text('It\'s rainy here'),
                  ),
                  Center(
                    child: Text('It\'s sunny here'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

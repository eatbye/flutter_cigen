import 'package:flutter/material.dart';

class CigenListPage extends StatefulWidget {
  String type;

  CigenListPage(this.type);

  @override
  _CigenListPageState createState() => _CigenListPageState(type);
}

class _CigenListPageState extends State<CigenListPage> {
  String type;

  _CigenListPageState(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(type)),
    );
  }
}

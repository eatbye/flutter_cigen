import 'package:flutter/material.dart';

class TempPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('词根词缀'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: Center(
        child: Text('test'),
      ),
    );
  }
}

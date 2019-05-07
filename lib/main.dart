import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/bottom_bar_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '词根词缀',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(elevation: 0.5, textTheme: TextTheme(title: TextStyle(fontSize: 17.0)))
      ),
      home: BottomBarPage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/bottom_bar_page.dart';
import 'package:flutter_cigen/page/favorite_list_page.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:provide/provide.dart';

//void main() => runApp(MyApp());

//void main() => runApp(ListViewApp());
//void main() => runApp(NotebookListPage());

void main(){
  //main函数里面引用provide
  var counter = Counter();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

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


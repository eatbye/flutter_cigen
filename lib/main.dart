import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/bottom_bar_page.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:provide/provide.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

//void main() => runApp(MyApp());

//void main() => runApp(ListViewApp());
//void main() => runApp(NotebookListPage());

void main() => FlutterBugly.postCatchedException(() {
  //main函数里面引用provide
  var counter = Counter();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
});

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



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

  @override
  void initState() {
    super.initState();

    initBugly();
  }

  //bugly加载
  void initBugly(){
    FlutterBugly.init(
//      androidAppId: "b07803fb45",
      iOSAppId: "301ca8382b",
      autoCheckUpgrade: false,

    ).then((_result) {
      print(_result.message);
    });
  }
}


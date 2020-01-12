import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/bottom_bar_page.dart';
import 'package:flutter_cigen/provider/theme_provider.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

//import 'package:fake_analytics/fake_analytics.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
//void main() => runApp(MyApp());

//void main() => runApp(ListViewApp());
//void main() => runApp(NotebookListPage());

/*
void main() => FlutterBugly.postCatchedException(() {
  //main函数里面引用provide
  var counter = Counter();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
});

 */

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*
  @override
  Widget build(BuildContext context) {
    //百度统计
    /*
    Analytics analytics = Analytics();
    if (Platform.isIOS) {
      analytics.startWork(
        appKey: '7c70cee572',  //词根词缀背单词
        appChannel: () => Future.value('official'),
        enableDebug: true,
      );
    }
    */



    return  MaterialApp(
        title: '词根词缀',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(elevation: 0.5, textTheme: TextTheme(title: TextStyle(fontSize: 17.0)))
        ),
        home: BottomBarPage(),
      );
  }

   */

  var counter = Counter();

  /*
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => counter),
      ],

      child: MaterialApp(
        title: '词根词缀',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(elevation: 0.5, textTheme: TextTheme(title: TextStyle(fontSize: 17.0)))
        ),
        home: BottomBarPage(),
      ),
    );
  }

   */

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => counter),
      ],

      child: ChangeNotifierProvider<ThemeProvider>(
        builder: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp(
              title: 'Flutter Deer',
              //showPerformanceOverlay: true, //显示性能标签
              debugShowCheckedModeBanner: false,
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              home: BottomBarPage(),
            );
          },
        ),
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      builder: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            title: 'Flutter Deer',
            //showPerformanceOverlay: true, //显示性能标签
            debugShowCheckedModeBanner: false,
            theme: provider.getTheme(),
            darkTheme: provider.getTheme(isDarkMode: true),
            home: BottomBarPage(),
          );
        },
      ),
    );
  }
   */



  @override
  void initState() {
    super.initState();

    initBugly();

    initUMeng();
  }

  //bugly加载
  void initBugly() {
    FlutterBugly.init(
//      androidAppId: "b07803fb45",
      iOSAppId: "301ca8382b",
      autoCheckUpgrade: false,
    ).then((_result) {
      print(_result.message);
    });
  }

  initUMeng() {
    // channel 可设置为空
    FlutterUmplus.init(
      '5d2bc6394ca3573fad000a15',
      channel: 'appstore',
      reportCrash: true,
      logEnable: false,
      encrypt: true,
    );
  }
}

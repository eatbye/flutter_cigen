import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cigen/page/bottom_bar_page.dart';
import 'package:flutter_cigen/page/cigen_tabbar_page.dart';
import 'package:flutter_cigen/provider/theme_provider.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_cigen/page/test_page.dart';
// import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';
import 'package:fl_umeng/fl_umeng.dart';

//import 'package:fake_analytics/fake_analytics.dart';
// import 'package:flutter_umplus/flutter_umplus.dart';
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

  var counter = Counter();

  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Counter())  //新的provider调用方法
      ],
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp( //MaterialApp
              title: '词根词缀',
              //showPerformanceOverlay: true, //显示性能标签
              debugShowCheckedModeBanner: false,
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: BottomBarPage(),
              // home: TestPage(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Counter>(create: (_) => Counter()),
      ],

      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
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
    // FlutterBugly.init(
    //   iOSAppId: "301ca8382b",
    //   autoCheckUpgrade: false,
    // ).then((_result) {
    //   print(_result.message);
    // });
  }

  initUMeng() {
    // channel 可设置为空
    // FlutterUmplus.init(
    //   '5d2bc6394ca3573fad000a15',
    //   channel: 'appstore',
    //   reportCrash: true,
    //   logEnable: false,
    //   encrypt: true,
    // );
    // await UMengAnalyticsPlugin.init(
    //   androidKey: '5d2bc6394ca3573fad000a15',
    //   iosKey: '5d2bc6394ca3573fad000a15',
    // );

    initWithUM(
        androidAppKey: '5d2bc6394ca3573fad000a15',
        iosAppKey: '5d2bc6394ca3573fad000a15',
        channel: 'appstore');
  }
}

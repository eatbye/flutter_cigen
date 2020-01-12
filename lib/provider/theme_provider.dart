import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/common/common.dart';
import 'package:flutter_cigen/common/themes.dart';
import 'package:flutter_cigen/res/colors.dart';
import 'package:flutter_cigen/res/styles.dart';


class ThemeProvider extends ChangeNotifier {

  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark", Themes.LIGHT : "Light", Themes.SYSTEM : "System"
  };

  void syncTheme(){
    String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]){
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    SpUtil.putString(Constant.theme, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false}) {
    String theme = SpUtil.getString(Constant.theme);
    switch(theme){
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }

    return ThemeData(
        errorColor: isDarkMode ? Colours.dark_red : Colours.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          title: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // TextField输入文字颜色
          subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.5,
          color: isDarkMode ? Colours.dark_bg_color : Colors.blue,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          textTheme: TextTheme(
            title: isDarkMode ? TextStyles.titleDartBold26 : TextStyles.titleBold26,
          ),
          iconTheme: IconThemeData(
            color: isDarkMode ? Colours.dark_text: Colors.white
          ),

        ),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        )
    );
  }

}
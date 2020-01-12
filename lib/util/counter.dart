import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int readValue = 0;
  int favoriteValue = 0;

  read(){
    readValue++;
    notifyListeners();        //通知引用该变量地方的改变值

  }

  favorite(){
    favoriteValue++;
    notifyListeners();

  }

}
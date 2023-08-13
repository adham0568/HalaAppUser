import 'package:flutter/material.dart';

class total with ChangeNotifier {

  int Num = 0;

  addNum() {
    Num++;
    notifyListeners();
  }

  removeNum() {
    Num>=0?
    Num--:null;
    notifyListeners();
  }

  Num1() {
    return Num;
    notifyListeners();
  }
  Clear(){
    Num=0;
  }
  @override
  notifyListeners();

}

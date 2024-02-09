import 'lightTheme.dart';
import 'darkTheme.dart';
import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier{

  //ilova ochilganda qullaniladigan lightMode bo'ladi
  ThemeData _themeData = lightMode;

  //ilovaga Mode tanlash uchun o'zgaruvchi olish
  ThemeData get themeData => _themeData;

  //_themeDatani lightMode yoki darkMode qilish
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}
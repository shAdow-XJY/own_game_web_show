import 'package:flutter/material.dart';

class ThemeModel{
  ThemeData themeData;

  ThemeModel({
    required this.themeData,
  });

  bool getDayMode(){
    return themeData == ThemeData.light();
  }
}

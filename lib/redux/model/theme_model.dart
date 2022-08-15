import 'package:flutter/material.dart';

class ThemeModel{
  Brightness brightness;

  ThemeModel({
    required this.brightness,
  });

  bool getDayMode(){
    return brightness == Brightness.light;
  }
}
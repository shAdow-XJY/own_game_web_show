import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../model/theme_model.dart';

class SetThemeDataAction {
  ThemeData? themeData;

  SetThemeDataAction({this.themeData}) : super();

  /// 设置themedata主题
  static ThemeModel setTheme(ThemeModel theme, SetThemeDataAction action) {
    theme.themeData = action.themeData!;
    return theme;
  }

}


/*
 * 绑定Action与动作
 */
final ThemeReducer = combineReducers<ThemeModel>([
  TypedReducer<ThemeModel, SetThemeDataAction>(SetThemeDataAction.setTheme),
]);


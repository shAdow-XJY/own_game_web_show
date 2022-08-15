import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../model/theme_model.dart';

class SetThemeDataAction {
  Brightness? brightness;

  SetThemeDataAction({this.brightness}) : super();

  /// 设置themedata主题
  static ThemeModel setTheme(ThemeModel theme, SetThemeDataAction action) {
    theme.brightness = action.brightness!;
    return theme;
  }

}


/*
 * 绑定Action与动作
 */
final ThemeReducer = combineReducers<ThemeModel>([
  TypedReducer<ThemeModel, SetThemeDataAction>(SetThemeDataAction.setTheme),
]);


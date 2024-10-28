
import 'package:flutter/material.dart';

import '../action/theme_action.dart';
import '../model/theme_model.dart';



class AppState {
  /// 保存我们的主题状态
  late ThemeModel themeModel;

  AppState({
    required this.themeModel,
  });

  /*
   * 命名的构造方法
   * 这里用来初始化
   */
  AppState.initialState() {
    themeModel = ThemeModel(brightness: Brightness.dark);
  }

  AppState copyWith ({themeModel,userModel,deviceModel}){
    return AppState(
      themeModel: themeModel ?? this.themeModel,
    );
  }

}

/// 定义Reducer
AppState appReducer(AppState state, action) {
  debugPrint(action.runtimeType.toString());
  switch(action.runtimeType){
    case SetThemeDataAction:
    {
      return state.copyWith(themeModel: ThemeReducer(state.themeModel, action));
    }
    default:
    {
      return state;
    }
  }

}

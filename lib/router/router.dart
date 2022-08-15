import 'package:flutter/material.dart';
import 'package:own_game_web_show/pages/markdown_page.dart';

import '../home/home.dart';


//需要引入跳转页面地址
// 配置路由
final routes = {
  // 前面是自己的命名 后面是加载的方法
  '/homePage' : (context) => const MyHomePage(),
  '/markdownPage' : (context, {arguments}) => MarkDownPage(title: arguments,),
};

// 固定写法，统一处理，无需更改
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  if (name != null) {
    final Function? pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  }
};
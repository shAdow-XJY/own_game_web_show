import 'package:flutter/material.dart';
import 'package:own_game_web_show/home/home.dart';
import 'package:own_game_web_show/redux/app_state/state.dart';
import 'package:own_game_web_show/router/router.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final store = Store<AppState>(appReducer, initialState: AppState.initialState());//创建 store

  @override
  Widget build(BuildContext context) {
    /// 使用StoreProvider 包裹根元素，使其提供store
    return StoreProvider(
        store: store,
        /// 为了能直接在child使用store，我们这里要继续包裹一层StoreBuilder
        child: StoreBuilder<AppState>(
            builder: (context, store) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'shadow game web',
                  theme: ThemeData(
                    brightness: store.state.themeModel.brightness,
                    fontFamily: 'Noto',
                    useMaterial3: true,
                  ),
                  initialRoute: '/homePage', //初始化加载的路由
                  onGenerateRoute: onGenerateRoute,
              );
            }
        )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/grid_card.dart';
import '../redux/action/theme_action.dart';
import '../redux/app_state/state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Map<String, String>> navigationObj = [
    {'gameName': 'Super Mario', 'imageUrl': 'assets/images/Super Mario.png'},
    {'gameName': 'Portal', 'imageUrl': 'assets/images/Portal.png'},
  ];

  final List<Map<String, String>> websiteObj = [
    {'gameName': 'Tic Tac Toe', 'imageUrl': 'assets/images/tic_tac_toe.png', 'linkUrl': 'https://shadowplusing.website/tic_tac_toe/'},
    {'gameName': 'Snake Game', 'imageUrl': 'assets/images/snake_game.png', 'linkUrl': 'https://shadowplusing.website/snake_game/'},
    {'gameName': 'Rock Paper Scissors', 'imageUrl': 'assets/images/rock_paper_scissors.png', 'linkUrl': 'https://shadowplusing.website/rock_paper_scissors/'},
    {'gameName': 'Parkour Game', 'imageUrl': 'assets/images/parkour_game.png', 'linkUrl': 'https://shadowplusing.website/parkour_game/'},
  ];

  int crossAxisCount = 5;

  bool dayMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const Text('Shadow\'s Game Center'),
          centerTitle: true,
          leading: StoreConnector<AppState, VoidCallback>(
            converter: (Store store) {
              /// 返回的就是下面的 VoidCallback callback
              return () => {
                dayMode = store.state.themeModel.getDayMode(),
                store.dispatch(SetThemeDataAction(brightness: dayMode ? Brightness.dark : Brightness.light,))
              };
            },
            builder: (BuildContext context, VoidCallback callback) {
              return IconButton(
                onPressed: () {
                  callback();
                },
                tooltip: 'day/night',
                icon:
                dayMode ? const Icon(Icons.sunny) : const Icon(Icons.brightness_2),
              );
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/images/GitHub.png')),
                  onPressed: () {
                    launchUrl(Uri.parse('https://github.com/shAdow-XJY/own_game_web_show'));
                  },
                ),
              ],
            )
          ],
        ),
        body: ResponsiveBuilder(
            builder: (context, sizingInformation){
              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile){
                crossAxisCount = 1;
              }else if(sizingInformation.deviceScreenType == DeviceScreenType.tablet){
                crossAxisCount = 3;
              }
              return GridView.builder(
                  itemCount: navigationObj.length + websiteObj.length,
                  //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: crossAxisCount,
                      //纵轴间距
                      mainAxisSpacing: 5.0,
                      //横轴间距
                      crossAxisSpacing: 10.0,
                      //子组件宽高长度比例
                      childAspectRatio: 0.9),
                  itemBuilder: (BuildContext context, int index) {
                    // 根据索引确定是哪个列表
                    if (index < navigationObj.length) {
                      // 从 navigationObj 中获取数据
                      var game = navigationObj[index];
                      return GridCard(
                        cardName: game['gameName'] ?? 'unknown',
                        assetImage: AssetImage(game['imageUrl'] ?? 'assets/images/unknown.png'),
                        onTap: () {
                          Navigator.pushNamed(context, '/markdownPage', arguments: game['gameName']);
                        },
                        tag: 'Repository', // 标签显示
                      );
                    } else {
                      // 从 websiteObj 中获取数据
                      var game = websiteObj[index - navigationObj.length];
                      return GridCard(
                        cardName: game['gameName'] ?? '',
                        assetImage: AssetImage(game['imageUrl'] ?? ''),
                        onTap: () {
                          launchUrl(Uri.parse(game['linkUrl'] ?? ''));
                        },
                        tag: 'Website', // 标签显示
                      );
                    };

                  });
            })
    );
  }
}

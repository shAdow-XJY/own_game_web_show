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

  var obj = [
    {'gameName': '前端面试-HTML+CSS.docx', 'imageUrl': 'assets/images/html5.png'},
    {'gameName': '前端面试-JavaScript.docx', 'imageUrl': 'assets/images/javascript.png'},
    {'gameName': '前端面试-Vue.docx', 'imageUrl': 'assets/images/vue.png'},
  ];

  int crossAxisCount = 5;

  bool dayMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: StoreConnector<AppState, VoidCallback>(
            converter: (Store store) {
              /// 返回的就是下面的 VoidCallback callback
              return () => {
                dayMode = store.state.themeModel.getDayMode(),
                store.dispatch(SetThemeDataAction(
                    themeData: dayMode ? ThemeData.dark() : ThemeData.light()))
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
                    launchUrl(Uri.parse('https://github.com/shAdow-XJY/noteview'));
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
                  itemCount: obj.length,
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
                    //Widget Function(BuildContext context, int index)
                    return GridCard(
                      cardName: obj[index]['gameName']??'',
                      assetImage: AssetImage(obj[index]['imageUrl']??''),
                    );

                  });
            })
    );
  }
}

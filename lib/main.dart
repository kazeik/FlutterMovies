import 'dart:io';

import 'package:android/pages/splash_page.dart';
import 'package:android/util/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:tencent_ad/tencent_ad.dart';

import 'app/app_color.dart';
import 'app/app_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 获取 jwt
  /* SharedPrefUtil prefUtil = new SharedPrefUtil();
  jwt = await prefUtil.getToken();*/
  bool success = await Storage.getInstance();
  // 创建一个持久化器
  final persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>(AppState.fromJson),
      debug: true);

  // 从 persistor 中加载上一次存储的状态
  final initialState = await persistor.load();

  final store = Store<AppState>(reducer,
      initialState: initialState ?? AppState(''),
      middleware: [persistor.createMiddleware()]);
  //runApp(MyApp(store));
  if (Platform.isAndroid) {
    // 设置沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    //runApp(MyApp(store));
    FlutterBugly.postCatchedException(() {
      runApp(MyApp(store));
    });
    FlutterBugly.init(androidAppId: "183f1cf3ce",iOSAppId: "b38b1ecc7a",channel: 'huawei');
  }
}

/*class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: '今日看片',
          theme: ThemeData(
            primaryColor: Colors.white,
            dividerColor: Color(0xFFEEEEEE),
            scaffoldBackgroundColor: AppColor.paper,
            */ /*textTheme: TextTheme(
                  body1: TextStyle(color: AppColor.darkGrey)
              )*/ /*
          ),
          //home: TabNavigator(),
          home: SplashPage(),
        ));
  }

}*/
class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: widget.store,
        child: MaterialApp(
          title: '今日看片',
          theme: ThemeData(
            primaryColor: Colors.white,
            dividerColor: Color(0xFFEEEEEE),
            scaffoldBackgroundColor: AppColor.paper,
            /*textTheme: TextTheme(
                  body1: TextStyle(color: AppColor.darkGrey)
              )*/
          ),
          //home: TabNavigator(),
          home: SplashPage(),
        ));
  }

  @override
  void initState() {
    super.initState();
    _setVodCachePath();
    TencentADPlugin.config(appID: '1101247946').then(
          (_) => SplashAD(
          posID: '5001912458046595',
          callBack: (event, args) {
            switch (event) {
              case SplashADEvent.onNoAD:
              case SplashADEvent.onADDismissed:
                SystemChrome.setEnabledSystemUIOverlays([
                  SystemUiOverlay.top,
                  SystemUiOverlay.bottom,
                ]);
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                );
                break;
              default:
            }
          }).showAD(),
    );

  }

  _setVodCachePath() async{
    ///设置播放缓存目录
    Directory vodCacheDir = await getTemporaryDirectory();
    String vodCachePath = vodCacheDir.path;
    await Storage.setString('vodCachePath', vodCachePath);
  }

}

import 'dart:convert';
import 'dart:io';

import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/home/home_list_view.dart';
import 'package:android/model/upgrade_info.dart';
import 'package:android/util/search_delegate.dart';
import 'package:android/widgets/app_upgrade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tencent_ad/tencent_ad.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   Upgradeinfo upgradeinfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          title: Text('首页'),
          backgroundColor: AppColor.white,
          //  app bar 阴影
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: SearchBarDelegate()),
            ),
          ],
        ),
        body: HomeListView());
  }

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  @override
  void dispose() {
    super.dispose();
  }

 _checkUpdate() async {
    MacApiClient client = MacApiClient();
    await client.getAppupgradeInfo().then((data) {
      if (data != null && mounted) {
        setState(() {
          upgradeinfo = Upgradeinfo.fromJson(data);
        });
      }
    }).then((_) async {
      if (Platform.isAndroid) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String appName = packageInfo.appName;
        String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        if (upgradeinfo != null) {
          if (double.parse(upgradeinfo.versionCode) >
              double.parse(buildNumber)) {
            // ignore: unnecessary_statements
            showDialog(context: context, builder: (ctx) => _buildDialog());
          }
        }
      }
    });
  }

  Widget _buildDialog() => Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 80,
          child: AppUpgrade(
            title: upgradeinfo.title,
            newFeature: upgradeinfo.newFeature,
            apkUrl: upgradeinfo.apkUrl,
            iosAppId: upgradeinfo.iosAppId,
          ),
        ),
      );

/*  _getAppupgradeInfo() async {
    MacApiClient client = MacApiClient();
    await client.getAppupgradeInfo().then((data) {
      print('data' + data.toString());
      setState(() {
        upgradeinfo = Upgradeinfo.fromJson(jsonDecode(data));
      });
    });
  }*/

/*// 获取安装地址
  Future<String> get _apkLocalPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

// 下载
 Future<void> _executeDownload() async {
    final path = await _apkLocalPath;
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: upgradeInfo.apkUrl,
        savedDir: path,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        _installApk();
      }
    });
  }

// 安装
  Future<Null> _installApk() async {
    // XXXXX为项目名
    const platform = const MethodChannel('im.qvod.movies');
    try {
      final path = await _apkLocalPath;
      // 调用app地址
      await platform
          .invokeMethod('install', {'path': path + '/app-release.apk'});
    } on PlatformException catch (_) {}
  }*/
}

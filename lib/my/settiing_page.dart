import 'dart:io';

import 'package:android/app/api_client.dart';
import 'package:android/model/open_player_contr.dart';
import 'package:android/model/upgrade_info.dart';
import 'package:android/util/screen.dart';
import 'package:android/util/storage.dart';
import 'package:android/widgets/app_upgrade.dart';
import 'package:android/widgets/web_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage(BuildContext context);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool autoCacheClean = Storage.getBool('autoCacheClean', defValue: false);

  //bool hidenM3u8 = Storage.getBool('hidenM3u8', defValue: false); //是否开启本地播放器
  //bool openXunlei = Storage.getBool('openXunlei', defValue: false); //是否开启迅雷下载
  bool autoSaveHistory =
      Storage.getBool('autoSaveHistory', defValue: true); //是否开启自动保存浏览记录
  String cacheSize = '';

  //bool openPlayerSet = false;
  PlayContr playContr;
  Upgradeinfo upgradeinfo;
  PackageInfo packageInfo;

  @override
  void initState() {
    _getCacheSize();
    _checkUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          title: Text('软件设置'),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('images/icon_arrow_back_black.png'),
          ),
        ),
        preferredSize: Size.fromHeight(Screen.height * 0.05),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 30,
          ),

          /*Offstage(
            offstage: _off,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: SwitchListTile(
                value: hidenM3u8,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withAlpha(88),
                activeColor: Colors.blue,
                activeTrackColor: Colors.orange,
                title: Text('本地播放器是否开启'),
                subtitle: Text('开启本地播放器体验高清视频和加速技术'),
                onChanged: (v) async {
                  await Storage.setBool('hidenM3u8', v);

                  ///设置播放缓存目录
                  Directory vodCacheDir = await getTemporaryDirectory();
                  String vodCachePath = vodCacheDir.path;
                  await Storage.setString('vodCachePath', vodCachePath);
                  setState(() {
                    hidenM3u8 = v;
                  });
                },
              ),
            ),
          ),

          ///迅雷下载设置
          Offstage(
            offstage: _off,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5)),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: SwitchListTile(
                  value: openXunlei,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.withAlpha(88),
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.orange,
                  title: Text('开启迅雷来源'),
                  subtitle: Text('开启迅雷来源增加播放来源'),
                  onChanged: (v) async {
                    await Storage.setBool('openXunlei', v);
                    setState(() {
                      openXunlei = v;
                    });
                  },
                )),
          ),*/

          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: SwitchListTile(
                value: autoSaveHistory,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withAlpha(88),
                activeColor: Colors.blue,
                activeTrackColor: Colors.orange,
                title: Text('是否开启自动保存观看记录'),
                subtitle: Text('如果不需要自动保存观看记录，请关闭'),
                onChanged: (v) async {
                  await Storage.setBool('autoSaveHistory', v);
                  setState(() {
                    autoSaveHistory = v;
                  });
                },
              )),

          ///退出播放自动删除缓存
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: SwitchListTile(
                value: autoCacheClean,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withAlpha(88),
                activeColor: Colors.blue,
                activeTrackColor: Colors.orange,
                title: Text('是否自动删除播放缓存'),
                subtitle: Text('开启本选项会在退出播放界面自动删除视频缓存,避免占用储存空间过多'),
                onChanged: (v) async {
                  await Storage.setBool('autoCacheClean', v);
                  setState(() {
                    autoCacheClean = v;
                  });
                },
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: ListTile(
                //leading: Icon(Icons.delete_outline,size: 36,),
                title: Text('清理缓存'),
                subtitle: Text('当前缓存大小：' + cacheSize),
                onTap: () {
                  _clearCache();
                  setState(() {
                    cacheSize = '已经清理，很干净';
                  });
                },
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: ListTile(
                //leading: Icon(Icons.delete_outline,size: 36,),
                title: Text('版本检查'),
                subtitle: Text('当前使用版本：' +
                    (packageInfo != null ? packageInfo.version : '0')),
                onTap: () {
                  if (double.parse(upgradeinfo.versionCode) >
                      double.parse(packageInfo.buildNumber)) {
                    showDialog(
                        context: context, builder: (ctx) => _upgradeDialog());
                  } else {
                    Fluttertoast.showToast(msg: '您使用的是最新版');
                  }
                },
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: ListTile(
                //leading: Icon(Icons.delete_outline,size: 36,),
                title: Text('隐私保护指引'),
                //subtitle: Text('当前缓存大小：' + cacheSize),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebScaffold(
                          title: '隐私保护指引',
                          url:
                              'http://www.jinrikanpian.net/app/androidPermission.html',
                        ),
                      ));
                },
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: ListTile(
                //leading: Icon(Icons.delete_outline,size: 36,),
                title: Text('关于今日看片'),
                //subtitle: Text('当前缓存大小：' + cacheSize),
                onTap: () {
                  showDialog(
                      context: context, builder: (ctx) => _buildAlertDialog());
                },
              )),
        ],
      ),
    );
  }

  _checkUpdate() async {
    MacApiClient client = MacApiClient();
    PackageInfo packageInfoTmp = await PackageInfo.fromPlatform();
    await client.getAppupgradeInfo().then((data) {
      if (data != null && mounted) {
        setState(() {
          upgradeinfo = Upgradeinfo.fromJson(data);
          packageInfo = packageInfoTmp;
        });
      }
    });
  }

  Widget _upgradeDialog() {
    if (upgradeinfo != null) {
      return Dialog(
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
    }
  }

  _getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    var valueTmp = _renderSize(value);
    setState(() {
      cacheSize = valueTmp;
    });
  }

  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  void _clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await delDir(tempDir);
    Fluttertoast.showToast(msg: '清除缓存成功');
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: _buildTitle(),
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      titlePadding: EdgeInsets.only(
        top: 5,
        left: 20,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      backgroundColor: Colors.white,
      content: _buildContent(),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebScaffold(
                    title: '免责声明',
                    url: 'http://www.jinrikanpian.net/app/copyright.html',
                  ),
                ));
          },
          child: Row(
            children: <Widget>[
              Text('免责声明'),
              Icon(Icons.info_outline),
            ],
          ),
        ),
      ],
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  Widget _buildTitle() {
    return Row(
      //标题
      children: <Widget>[
        /* Image.asset(
          "assets/images/icon_head.png",
          width: 30,
          height: 30,
        ),*/
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "关于今日看片",
          style: TextStyle(fontSize: 18),
        )),
        CloseButton()
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            ' 今日看片是一款全网视频聚合App。'
            '收录主流视频网站精彩影视，'
            '让您第一时间获取最新影视更新。'
            '更多功能可以在App设置中查看设置。',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:android/model/movie_detail.dart';
import 'package:android/plugins/tencentplayer/util/play_type.dart';
import 'package:android/util/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screen/screen.dart';
import 'package:tencent_ad/reward.dart';
import 'package:tencent_ad/tencent_ad.dart';

import 'util/forbidshot_util.dart';
import 'widget/tencent_player_bottom_widget.dart';
import 'widget/tencent_player_gesture_cover.dart';
import 'widget/tencent_player_loading.dart';

class FullVideoPage extends StatefulWidget {
  PlayType playType;
  String dataSource;
  TencentPlayerController controller;

  //UI
  bool showBottomWidget;
  bool showClearBtn;
  List<Urls> urlsList;
  int currentClearIndex;

  FullVideoPage(
      {this.controller,
      this.showBottomWidget = true,
      this.showClearBtn = true,
      this.dataSource,
      this.playType = PlayType.network,
      this.urlsList,
      this.currentClearIndex});

  @override
  _FullVideoPageState createState() => _FullVideoPageState();
}

class _FullVideoPageState extends State<FullVideoPage> {
  TencentPlayerController controller;
  VoidCallback listener;

  bool isLock = false;
  bool showCover = false;
  Timer timer;
  List<String> clearUrlList = [];
  int currentClearIndex = 0;

  ///改路径在App设置也开启本地播放器就设置好
  String appCachePath = Storage.getstaticString('vodCachePath');
  ValueNotifierData vd = ValueNotifierData('0');

  ///腾讯视频广告位置id
  final String posId = '7081636463867134';
  IntersAD intersAD;

  _FullVideoPageState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  @override
  void initState() {
    setState(() {
      currentClearIndex = widget.currentClearIndex;
    });
    super.initState();
    _coverUrlsToclearUrlList();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initController();
    hideCover();
    //ForbidShotUtil.initForbid(context);
    Screen.keepOn(true);

    controller.addListener(() {
      vd.value = (currentClearIndex).toString();
      if (controller.value.position.inSeconds >= 10) {
        if (controller.value.position.inSeconds >=
            controller.value.duration.inSeconds) {
          var hasData = widget.urlsList.indexWhere((item) {
            return item.url == widget.dataSource;
          });
          if (hasData != -1 && currentClearIndex < clearUrlList.length - 1) {
            currentClearIndex += 1;
            widget.dataSource = widget.urlsList[currentClearIndex].url;
            _initController();
            //setState(() {});

          }
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
    /*
    rewardAD = RewardAD(posID: posID, adEventCallback: _adEventCallback);
    rewardAD.loadAD();*/

    intersAD = IntersAD(posID: posId, adEventCallback: _adEventCallback);
    intersAD.loadAD();
  }

  @override
  dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    controller.removeListener(listener);
    if (widget.controller == null) {
      controller.dispose();
    }
    //ForbidShotUtil.disposeForbid();
    Screen.keepOn(false);
    if (Storage.getBool('autoCacheClean', defValue: false) == true) {
      ///退出播放界面自动清空播放缓存
      _clearCache();
    }
  }

  _initController() async {
    if (widget.controller != null) {
      controller = widget.controller;
      return;
    }
    switch (widget.playType) {
      case PlayType.network:
        controller = TencentPlayerController.network(widget.dataSource,
            playerConfig:
                PlayerConfig(cachePath: appCachePath, autoPlay: false));
        break;
      case PlayType.asset:
        controller = TencentPlayerController.asset(widget.dataSource);
        break;
      case PlayType.file:
        controller = TencentPlayerController.file(widget.dataSource);
        break;
      case PlayType.fileId:
        controller = TencentPlayerController.network(null,
            playerConfig: PlayerConfig(
                auth: {"appId": 1251203810, "fileId": widget.dataSource}));
        break;
    }
    controller.initialize();
    controller.addListener(listener);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          hideCover();
        },
        onDoubleTap: () {
          if (!widget.showBottomWidget || isLock) return;
          if (controller.value.isPlaying) {
            controller.pause();
            intersAD.loadAD();
          } else {
            controller.play();
          }
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              /// 视频
              controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: TencentPlayer(controller),
                    )
                  : Image.asset('images/tencentplayer/place_nodata.png'),

              /// 支撑全屏
              Container(),

              /// 半透明浮层
              showCover ? Container(color: Color(0x7f000000)) : SizedBox(),

              /// 处理滑动手势
              Offstage(
                offstage: isLock,
                child: TencentPlayerGestureCover(
                  controller: controller,
                  showBottomWidget: widget.showBottomWidget,
                  behavingCallBack: delayHideCover,
                ),
              ),

              /// 加载loading
              TencentPlayerLoading(
                controller: controller,
                iconW: 53,
              ),

              /// 头部浮层
              !isLock && showCover
                  ? Positioned(
                      top: 0,
                      left: MediaQuery.of(context).padding.top,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 34, left: 10),
                          child: Image.asset(
                            'images/tencentplayer/icon_back.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),

              /// 锁
              showCover
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            isLock = !isLock;
                          });
                          delayHideCover();
                          if (Platform.isAndroid) {
                            DeviceOrientation deviceOrientation =
                                controller.value.orientation < 180
                                    ? DeviceOrientation.landscapeRight
                                    : DeviceOrientation.landscapeLeft;
                            if (isLock) {
                              SystemChrome.setPreferredOrientations(
                                  [deviceOrientation]);
                            } else {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);
                            }
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            right: 20,
                            bottom: 20,
                            left: MediaQuery.of(context).padding.top,
                          ),
                          child: Image.asset(
                            isLock
                                ? 'images/tencentplayer/player_lock.png'
                                : 'images/tencentplayer/player_unlock.png',
                            width: 38,
                            height: 38,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),

              /// 进度、清晰度、速度
              Offstage(
                offstage: !widget.showBottomWidget,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).padding.top,
                      right: MediaQuery.of(context).padding.bottom),
                  child: TencentPlayerBottomWidget(
                    isShow: !isLock && showCover,
                    controller: controller,
                    showClearBtn: widget.showClearBtn,
                    behavingCallBack: () {
                      delayHideCover();
                    },
                    changeClear: (int index) {
                      changeClear(index);
                    },
                    urlsList: widget.urlsList,
                    currentClearIndex: currentClearIndex,
                    data: vd,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeClear(int urlIndex, {int startTime = 0}) {
    controller?.removeListener(listener);
    controller?.pause();
    controller = TencentPlayerController.network(clearUrlList[urlIndex],
        playerConfig: PlayerConfig(
            cachePath: appCachePath,
            startTime: startTime ?? controller.value.position.inSeconds));
    currentClearIndex = urlIndex;
    controller?.initialize().then((_) {
      if (mounted) setState(() {});
    });
    controller?.addListener(listener);
  }

  hideCover() {
    if (!mounted) return;
    setState(() {
      showCover = !showCover;
    });
    delayHideCover();
  }

  delayHideCover() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    if (showCover) {
      timer = new Timer(Duration(seconds: 6), () {
        if (!mounted) return;
        setState(() {
          showCover = false;
        });
      });
    }
  }

  _coverUrlsToclearUrlList() {
    List<String> urlsTmp = [];
    widget.urlsList.forEach((urls) {
      urlsTmp.add(urls.url);
    });
    setState(() {
      clearUrlList = urlsTmp;
    });
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

  void _clearCache() async {
    Directory tempDir = Directory(appCachePath + '/txvodcache');

    ///删除缓存目录
    await delDir(tempDir);
    //await loadCache();
    Fluttertoast.showToast(msg: '已为您自动清除播放缓存');
  }

void _adEventCallback(IntersADEvent event, Map params) {
    switch (event) {
      case IntersADEvent.onADReceived:
        intersAD.showAD();
        break;
      case IntersADEvent.onADClosed:
        controller.play();
        break;
      default:
    }
  }

  /*void _adEventCallback(RewardADEvent event, Map params) {
    switch (event) {
      case RewardADEvent.onADLoad:
        rewardAD.showAD();
        break;

      case RewardADEvent.onADClose:
        //Fluttertoast.showToast(msg: '关闭了');
        controller.play();
        break;
        *//*case RewardADEvent.onVideoComplete:
        //Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(32.0),
                  child: Card(
                    child: Container(
                      width: 320.0,
                      height: 280.0,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        '恭喜你获得${money.toStringAsFixed(2)}元',
                        textScaleFactor: 2.1,
                      ),
                    ),
                  ),
                ),
              );
            });*//*
        break;
      default:
    }
  }*/
}

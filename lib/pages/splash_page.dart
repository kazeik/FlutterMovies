import 'package:android/app/api_client.dart';
import 'package:android/model/splash_model.dart';
import 'package:android/navigator/tab_navigator.dart';
import 'package:android/util/storage.dart';
import 'package:android/util/utils.dart';
import 'package:android/widgets/web_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  /*SplashModel model = new SplashModel(
    title: 'Flutter 常用工具类库',
    content: 'Flutter 常用工具类库',
    url: 'https://www.baidu.com',
    imgUrl:
        'http://www.jinrikanpian.net/upload/vod/20200510-1/f1b2ae6824fe76e5b841e7a953444503.jpg',
  );*/
  TimerUtil _timerUtil;

  List<String> _guideList = [
    /*Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),*/
  ];

  List<Widget> _bannerList = new List();

  int _status = 0;
  int _count = 3;

  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _loadSplashData();
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      if (Storage.getBool('key_guide', defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        Storage.setBool('key_guide', false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  void _loadSplashData() {
    /*_splashModel =
        Storage.getObj('key_splash_models', (v) => SplashModel.fromJson(v));
    if (_splashModel != null) {
      setState(() {});
    }*/
    MacApiClient client = MacApiClient();
    client.getSplash().then((result) {
      setState(() {
        //_splashModel = SplashModel.fromJson(result);
      });
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 60.0),
                child: new InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: new CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: new Padding(
                      padding: EdgeInsets.all(2.0),
                      child: new Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _initSplash() {
    if (_splashModel == null) {
      //_getTencentSplshAd();
      _goMain();
    } else {
      _doCountDown();
    }
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 8 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TabNavigator()));
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      Utils.getImgPath('splash_bg'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  Widget _buildAdWidget(context) {
    if (_splashModel == null) {
      return new Container(
        height: 0.0,
      );
    }
    return new Offstage(
      offstage: !(_status == 1),
      child: new InkWell(
        onTap: () {
          if (ObjectUtil.isEmpty(_splashModel.url)) return;
          _timerUtil.cancel();
          _goMain();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebScaffold(
                  title: _splashModel.title,
                  url: _splashModel.url,
                ),
              ));
        },
        child: new Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: _splashModel.imgUrl,
            placeholder: (context, url) => _buildSplashBg(),
            errorWidget: (context, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? Container()
                : Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                      radius: 4.0,
                      padding: EdgeInsets.only(bottom: 30.0),
                      itemColor: Colors.black26,
                    ),
                    children: _bannerList),
          ),
          _buildAdWidget(context),
          new Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _timerUtil.cancel();
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: new Text(
                      '剩余$_count' + '秒',
                      /*IntlUtil.getString(context, Ids.jump_count,
                          params: ['$_count']),*/
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Color(0xffe5e5e5)))),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timerUtil.cancel();
    super.dispose();
    //if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}

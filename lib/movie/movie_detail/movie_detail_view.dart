import 'dart:convert';

import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/model/movie_actor_detail.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movie_service.dart';
import 'package:android/util/screen.dart';
import 'package:android/util/storage.dart';
import 'package:android/widgets/web_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_ad/banner.dart';
import 'package:underline_indicator/underline_indicator.dart';

import 'movie_content_view.dart';
import 'movie_detail_cast_view.dart';
import 'movie_detail_header.dart';
import 'movie_detail_tag.dart';
import 'movie_xunlei_view.dart';

const X5_SUPPORT = ['m3u8', 'mp4', 'flv', 'avi', '3gp', '3gpp', 'webm'];

class MovieDetailView extends StatefulWidget {
  // 电影 id
  final String id;
  final MovieDetailMac movie;

  const MovieDetailView({Key key, this.id, this.movie}) : super(key: key);

  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  //MovieDetail movieDetail;
  double navAlpha = 0;
  ScrollController scrollController = ScrollController();
  Color pageColor = AppColor.darkGrey;
  bool isSummaryUnfold = false;
  bool isFavor = false;
  List<Urls> urls;
  TabController _controller;
  bool autoSaveHistory = Storage.getBool('autoSaveHistory', defValue: true);
  var crashInfo;
  bool isLoadOk = false;

  //MovieDetailMac movieTmp; //收藏，播放记录用该对象
  List<VodPlayList> vodPlayListTmp = [];
  List<MovieActorDetail> actors = [];

  actorsString2List() {}

  @override
  initState() {
    //loadMovie();
    _getIsFav();
    // loadX5();
    _controller = TabController(length: 0, vsync: this);
    if (widget.movie.vodPlayList != null) {
      widget.movie.vodPlayList
          .sort((a, b) => b.urls.length.compareTo(a.urls.length));
      vodPlayListTmp = this.widget.movie.vodPlayList.where((value) {
        return value.from != 'ckm3u8';
      }).toList();
      if (vodPlayListTmp != null) {
        setState(() {
          _controller =
              TabController(length: vodPlayListTmp.length, vsync: this);
        });
      }
    }
    fetchDataColor();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
    if (autoSaveHistory == true) {
      historyMovie();
    }
    _getActorsDetail();
    super.initState();
  }

  @override
  void dispose() {
    _updateMovieHits();
    scrollController.dispose();
    _controller.dispose();
    super.dispose();
    //MovieServices.removeList('historyMovie');
    /*MovieServices.removeList('favMovies');*/
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    super.build(context);
    if (this.widget.movie == null) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              onTap: back,
              child: Image.asset('images/icon_arrow_back_black.png'),
            ),
          ),
          body: Center(
            child: CupertinoActivityIndicator(),
          ));
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: pageColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 0),
              children: <Widget>[
                MovieDetailHeader(
                    movie: this.widget.movie, coverColor: pageColor),
                MovieContentView(
                  text: widget.movie.vodContent,
                ),
                MovieDetailTag(widget.movie.vodTag.split(',')),
                MovieXunleiDownView(movie: widget.movie),
                _buildPlayList(),
                MovieDetailCastView(actors),
              ],
            ),
          ),
          // Container(color: pageColor,padding: EdgeInsets.symmetric(vertical: 300),),
          buildNavigationBar(),
        ],
      ),
    );
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 50,
              height: Screen.navigationBarHeight,
              padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
              child: GestureDetector(
                  onTap: back,
                  child: Image.asset('images/icon_arrow_back_white.png')),
            ),
            Container(
              width: 50,
              height: Screen.navigationBarHeight,
              padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
              child: GestureDetector(
                onTap: isFavor ? cancelFavor : favorMovie,
                child: isFavor
                    ? Icon(
                        Icons.favorite,
                        color: AppColor.white,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: AppColor.white,
                      ),
              ),
            ),
          ],
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(color: pageColor),
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                      onTap: back,
                      child: Image.asset('images/icon_arrow_back_white.png')),
                ),
                Expanded(
                  child: Text(
                    this.widget.movie.vodName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 44,
                  child: GestureDetector(
                      onTap: isFavor ? cancelFavor : favorMovie,
                      child: isFavor
                          ? Icon(
                              Icons.favorite,
                              color: AppColor.white,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: AppColor.white,
                            )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // 返回上个页面
  back() {
    Navigator.pop(context);
  }

  ///展开 or 收起
  changeSummaryMaxLines() {
    double height = (Screen.height / 2) * 0.68;
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
    showModalBottomSheet(
        backgroundColor: pageColor,
        context: context,
        builder: (context) => Container(
            height: height,
            child: Text(
              this.widget.movie.vodContent,
              style: TextStyle(color: AppColor.white, fontSize: 16.0),
            )));
  }

//收藏 直接存放在本机
  favorMovie() async {
    //MovieServices.setData('favMovies', widget.movie);
    MovieServices.setData('favMovies', widget.movie);
    setState(() {
      isFavor = true;
    });
    Fluttertoast.showToast(msg: '收藏成功！');
  }

  // 取消收藏
  cancelFavor() async {
    List moviesListData = await MovieServices.getList('favMovies');

    try {
      moviesListData.removeWhere((item) {
        return item['vod_id'] == widget.movie.vodId;
      });

      ///不能使用MovieServices.setHistoryData方法
      Storage.setString('favMovies', json.encode(moviesListData));
    } catch (e) {
      return [];
    }
    setState(() {
      isFavor = false;
    });
    Fluttertoast.showToast(msg: '收藏已取消！');
  }

  ///添加观看记录
  historyMovie() async {
    List histroyListData = await MovieServices.getList('historyMovie');
    var hasData = histroyListData.indexWhere((item) {
      //return item['vod_id'] == widget.movie.vodId;
      return item['vod_id'] == widget.movie.vodId;
    });
    if (hasData == -1) {
      //MovieServices.setData('historyMovie', widget.movie);
      MovieServices.setData('historyMovie', widget.movie);
    } else {
      histroyListData[hasData] = widget.movie;
      Storage.setString('historyMovie', json.encode(histroyListData));
    }
  }

  _getActorsDetail() async {
    MacApiClient client = MacApiClient();
    List<MovieActorDetail> listTmp = [];
    if (widget.movie.vodActor != '' && widget.movie.vodActor != null) {
      await client.getActorsDetail(widget.movie.vodActor).then((result) {
        result.forEach((data) {
          listTmp.add(MovieActorDetail.fromJson(data));
        });
      });
      if (mounted) {
        setState(() {
          actors = listTmp;
        });
      }
    }
  }

  Future<void> fetchDataColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(this.widget.movie.vodPic),
    );
    if (mounted) {
      setState(() {
        if (paletteGenerator.darkVibrantColor != null) {
          pageColor = paletteGenerator.darkVibrantColor.color;
        } else {
          pageColor = Color(0xff35374c);
        }
        // pageColor =paletteGenerator.dominantColor?.color;
      });
    }
  }

  _builderUrl(BuildContext context, List<Urls> urls) {
    // ignore: missing_return
    return urls.map((url) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebScaffold(
                  title: url.name,
                  url: url.url,
                ),
              ));
        },
        child: Container(
          //height: 15,
          alignment: Alignment.center,
          child: Text(
            url.name.replaceAll('-', '').replaceAll('期', ''),
            style: TextStyle(color: Colors.white, fontSize: 15),
            maxLines: 1,
          ),
          color: Colors.grey,
        ),
      );
    }).toList();
  }

  _buildPlayList() {
    if (vodPlayListTmp == null || vodPlayListTmp.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Text(
          '',
          style: TextStyle(fontSize: 18, color: AppColor.red),
        ),
      );
    } else {
      //播放地址最多的排第一
      vodPlayListTmp.sort((a, b) => b.urls.length.compareTo(a.urls.length));
      double height;
      if (vodPlayListTmp[0].urls.length % 4 == 0) {
        height = ((vodPlayListTmp[0].urls.length ~/ 4) *
            ((Screen.width - 30) / 8 + 10));
      } else {
        height = (vodPlayListTmp[0].urls.length ~/ 4 + 1) *
            ((Screen.width - 30) / 8 + 10);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              indicator: UnderlineIndicator(
                  strokeCap: StrokeCap.round,
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 5,
                  ),
                  insets: EdgeInsets.only(bottom: 10)),
              // ignore: missing_return
              tabs: vodPlayListTmp.map<Tab>((tab) {
                return Tab(
                  child: Text(
                    tab.playerInfo.show,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white),
                  ),
                );
              }).toList()),
          Container(
            height: height,
            child: TabBarView(
                dragStartBehavior: DragStartBehavior.down,
                physics: NeverScrollableScrollPhysics(), //禁止滑动
                controller: _controller,
                // ignore: missing_return
                children: vodPlayListTmp.map((tab) {
                  return GridView.count(
                    //scrollDirection:Axis.horizontal,
                    //shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //水平子Widget之间间距
                    crossAxisSpacing: 10.0,
                    //垂直子Widget之间间距
                    mainAxisSpacing: 10.0,
                    //GridView内边距
                    padding: EdgeInsets.all(0),
                    //一行的Widget数量
                    crossAxisCount: 4,
                    //子Widget宽高比例
                    childAspectRatio: 2,
                    //子Widget列表
                    children: _builderUrl(context, tab.urls),
                  );
                }).toList()),
          ),
        ],
      );
    }
  }

/*  var isLoad = false;

  void loadX5() async {
    if (isLoad) {
      showMsg("你已经加载过x5内核了,如果需要重新加载，请重启");
      return;
    }

    //请求动态权限，6.0安卓及以上必有
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.storage,
    ].request();
    //判断权限
    if (!(statuses[Permission.phone].isGranted &&
        statuses[Permission.storage].isGranted)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("请同意所有权限后再尝试加载X5"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("取消")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      loadX5();
                    },
                    child: Text("再次加载")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: Text("打开设置页面")),
              ],
            );
          });
      return;
    }

    //没有x5内核，是否在非wifi模式下载内核。默认false
    await X5Sdk.setDownloadWithoutWifi(true);

    //内核下载安装监听
    await X5Sdk.setX5SdkListener(X5SdkListener(onInstallFinish: () {
      // print("X5内核安装完成");
    }, onDownloadFinish: () {
      // print("X5内核下载完成");
    }, onDownloadProgress: (int progress) {
      //print("X5内核下载中---$progress%");
    }));
    //print("----开始加载内核----");
    var isOk = await X5Sdk.init();
    //print(isOk ? "X5内核成功加载" : "X5内核加载失败");

    var x5CrashInfo = await X5Sdk.getCrashInfo();
    //print(x5CrashInfo);
    if (isOk) {
      x5CrashInfo =
          "tbs_core_version" + x5CrashInfo.split("tbs_core_version")[1];
    }
    setState(() {
      isLoadOk = isOk;
      crashInfo = x5CrashInfo;
    });

    isLoad = true;
  }

  void showMsg(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("我知道了"))
            ],
          );
        });
  }

  openVideoX5(url) async {
    await X5Sdk.openVideo(url, screenMode: 102);
  }*/

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

//判断当前电影有没有被收藏
  _getIsFav() async {
    var _favListData = await MovieServices.getList('favMovies');
    var hasData = _favListData.indexWhere((item) {
      return item['vod_id'] == widget.movie.vodId;
    });
    //print('在对象数组中的位置'+hasData.toString());
    if (hasData != -1) {
      setState(() {
        isFavor = true;
      });
    }
  }

  ///更新点击次数
  _updateMovieHits() async {
    MacApiClient client = MacApiClient();
    await client.updateMovieHits(1, widget.movie.vodId, 'update');
  }

  Widget _buildBanner() {
    final _adKey = GlobalKey<BannerADState>();
    final size = MediaQuery.of(context).size;
    return BannerAD(
      posID: '1080505772141300',
      key: _adKey,
      callBack: (event, args) {
        switch (event) {
          case BannerEvent.onADClosed:
          case BannerEvent.onADCloseOverlay:
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(1.0, size.height * .82, 0.0, 0.0),
              items: [
                PopupMenuItem(
                  child: Text('刷新'),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text('关闭'),
                  value: 1,
                ),
              ],
            ).then((value) {
              switch (value) {
                case 0:
                  _adKey.currentState.loadAD();
                  break;
                case 1:
                  _adKey.currentState.closeAD();
                  Navigator.pop(context);
                  break;
                default:
              }
            });
            break;
          default:
        }
      },
      refresh: true,
    );
  }
}

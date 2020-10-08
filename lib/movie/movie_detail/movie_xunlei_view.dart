import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/model/open_player_contr.dart';
import 'package:android/plugins/tencentplayer/full_video_page.dart';
import 'package:android/plugins/tencentplayer/util/play_type.dart';
import 'package:android/util/screen.dart';
import 'package:android/util/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:underline_indicator/underline_indicator.dart';

// ignore: must_be_immutable
class MovieXunleiDownView extends StatefulWidget {
  MovieDetailMac movie;

  MovieXunleiDownView({Key key, this.movie}) : super(key: key);

  @override
  _MovieXunleiDownViewState createState() => _MovieXunleiDownViewState();
}

class _MovieXunleiDownViewState extends State<MovieXunleiDownView>
    with TickerProviderStateMixin {
  TabController _controller;
  List<VodPlayList> localPlayList = [];
  var listM3u8;

  @override
  void initState() {
    if (widget.movie.vodDownList != null) {
      localPlayList.addAll(widget.movie.vodDownList);
    }
    if (widget.movie.vodPlayList != null) {
      listM3u8 = (widget.movie.vodPlayList.where((v) {
        return v.from == 'ckm3u8';
      }));
    }

    if (listM3u8 != null && listM3u8.length > 0) {
      localPlayList.addAll(listM3u8);
    }
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    if (localPlayList != null) {
      setState(() {
        _controller = TabController(length: localPlayList.length, vsync: this);
      });
    }
    _getPremiss();
  }

  @override
  Widget build(BuildContext context) {
    if (localPlayList == null || localPlayList.length == 0) {
      return Container(
          /* padding: EdgeInsets.only(left: 5),
        child: Text(
          '',
          style: TextStyle(fontSize: 18, color: AppColor.red),
        ),*/
          );
    } else {
      double height;
      if (localPlayList[0].urls.length % 4 == 0) {
        height = ((localPlayList[0].urls.length ~/ 4) *
            ((Screen.width - 30) / 8 + 10));
      } else {
        height = (localPlayList[0].urls.length ~/ 4 + 1) *
            ((Screen.width - 30) / 8 + 10);
      }
      return Column(
        mainAxisSize: MainAxisSize.max,
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
              tabs: localPlayList.map<Tab>((tab) {
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
                //dragStartBehavior: DragStartBehavior.down,
                physics: NeverScrollableScrollPhysics(), //禁止滑动
                controller: _controller,
                // ignore: missing_return
                children: localPlayList.map((tab) {
                  return GridView.count(
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
                    childAspectRatio: 2.0,
                    //子Widget列表
                    children: _buildDownUrl(context, tab.urls),
                  );
                }).toList()),
          ),
        ],
      );
    }
  }

  _buildDownUrl(BuildContext context, List<Urls> urls) {
    return urls.map((url) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => FullVideoPage(
                    playType: PlayType.network,
                    dataSource: url.url,
                    urlsList: urls,
                    currentClearIndex: urls.indexOf(url),
                  )));
        },
        /*onTap: () {
          openVideoX5(url.url);
        },*/
        child: Container(
          // height: 15,
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

  _getPremiss() async {
    //请求动态权限，6.0安卓及以上必有
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.storage,
      Permission.locationWhenInUse,
    ].request();
    //判断权限
    if (!(statuses[Permission.phone].isGranted &&
        statuses[Permission.storage].isGranted)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("请同意所有权限后以便流畅观影"),
              actions: [
                /*FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("取消")),*/
                FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    //请求动态权限，6.0安卓及以上必有
                    await [
                      Permission.phone,
                      Permission.storage,
                      Permission.locationWhenInUse,
                    ].request();
                  },
                  child: Text("再次请求必要权限", style: TextStyle(color: Colors.blue)),
                ),
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
  }
}

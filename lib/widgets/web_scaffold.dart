import 'dart:convert';

import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/model/ban_urls.dart';
import 'package:android/util/navigator_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

import 'likebtn/like_button.dart';

class WebScaffold extends StatefulWidget {
  WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
  WebViewController _webViewController;

//  bool _isShowFloatBtn = false;
  var banUrls = ['youku', 'sohu', 'mgtv', 'iqiyi', 'itm','letvclient'];

  //var banUrls;
  //BanUrls banUrls;

  void _onPopSelected(String value) {
    String _title = widget.title ?? widget.titleId;
    switch (value) {
      case "browser":
        NavigatorUtil.launchInBrowser(widget.url, title: _title);
        break;
      case "collection":
        break;
      case "share":
        String _url = widget.url;
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title ?? widget.titleId,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          /*LikeButton(
            width: 56.0,
            duration: Duration(milliseconds: 500),
          ),*/
//          new IconButton(icon: new Icon(Icons.more_vert), onPressed: () {}),
          new PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: "browser",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: AppColor.gray_66,
                                    size: 22.0,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '浏览器打开',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.text_normal),
                                  )
                                ],
                              ),
                            ))),
//                    new PopupMenuItem<String>(
//                        value: "collection",
//                        child: ListTile(
//                            contentPadding: EdgeInsets.all(0.0),
//                            dense: false,
//                            title: new Container(
//                              alignment: Alignment.center,
//                              child: new Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.collections,
//                                    color: Colours.gray_66,
//                                    size: 22.0,
//                                  ),
//                                  Gaps.hGap10,
//                                  Text(
//                                    '收藏',
//                                    style: TextStyles.listContent,
//                                  )
//                                ],
//                              ),
//                            ))),
                    new PopupMenuItem<String>(
                        value: "share",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: AppColor.gray_66,
                                    size: 22.0,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '分享',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.text_normal,
                                    ),
                                  )
                                ],
                              ),
                            ))),
                  ])
        ],
      ),
      body: new WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
//          _webViewController.addListener(() {
//            int _scrollY = _webViewController.scrollY.toInt();
//            if (_scrollY < 480 && _isShowFloatBtn) {
//              _isShowFloatBtn = false;
//              setState(() {});
//            } else if (_scrollY > 480 && !_isShowFloatBtn) {
//              _isShowFloatBtn = true;
//              setState(() {});
//            }
//          });
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          //路由委托（可以通过在此处拦截url实现JS调用Flutter部分）
          for (final value in banUrls) {
            if (request.url?.startsWith(value) ?? false) {
              // Fluttertoast.showToast(msg: 'JS调用了Flutter By navigationDelegate');
              /* print('blocking navigation to $request}');*/
              return NavigationDecision.prevent;

              ///阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
            }
          }

          ///通过拦截url来实现js与flutter交互,不允许打开第三方App
          /*if (request.url.startsWith('sohu')) {
            Fluttertoast.showToast(msg:'JS调用了Flutter By navigationDelegate');
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;///阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
          }*/

          return NavigationDecision.navigate;

          ///允许路由替换
        },
        userAgent:
            'User-Agent:Mozilla/5.0 (iPhone; CPU iPhone OS 12_1_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
        onPageFinished: (url) {
          _webViewController
              .evaluateJavascript("document.title")
              .then((result) {
            setState(() {
              widget.title = result;
            });
          });
        },
      ),
//      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}

import 'package:android/app/app_color.dart';
import 'package:android/my/settiing_page.dart';
import 'package:android/widgets/web_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 56,
//      "name": 'PopupMenuButton基本使用',
//      "priority": 1,
//      "subtitle":
//          "【itemBuilder】 : 构造器   【PopupMenuItemBuilder<T>】\n"
//          "【offset】 : 偏移   【Offset】\n"
//          "【color】 : 背景颜色   【Color】\n"
//          "【shape】 : 形状   【ShapeBorder】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【onCanceled】 : 取消事件   【Function()】\n"
//          "【onSelected】 : 选择事件   【Function(T)】",
//    }
class CustomPopupMenuButton extends StatefulWidget {
  @override
  _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  final map = {
    "软件设置": Icons.settings_applications,
   // "问题反馈": Icons.add_comment,
    "关于": Icons.info_outline,
   // "帮助": Icons.help_outline,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => buildItems(),
      offset: Offset(0, 500),
      color: Color(0xffF4FFFA),
      elevation: 1,
      icon: Icon(Icons.settings_applications),
      captureInheritedThemes: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      )),
      onSelected: (e) {
        if (e == '关于') {
          // DialogAbout.show(context);
          showDialog(context: context, builder: (ctx) => _buildAlertDialog());
        }
        /*if (e == '问题反馈') {
          // DialogAbout.show(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebScaffold(
                  title: '问题反馈',
                  url: 'http://www.jinrikanpian.net/gbook/',
                ),
              ));
        }*/
        if (e == '软件设置') {
          // DialogAbout.show(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingPage(context),
              ));
        }
      },
      onCanceled: () => print('onCanceled'),
    );
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.blue,
                ),
                Text(e),
              ],
            )))
        .toList();
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

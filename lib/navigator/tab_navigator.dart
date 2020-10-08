import 'package:android/pages/home_page.dart';
import 'package:android/pages/jieshuo_page.dart';
import 'package:android/pages/my_page.dart';
import 'package:android/pages/search_page.dart';
import 'package:android/pages/top_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with AutomaticKeepAliveClientMixin{
  final PageController _controller = PageController(initialPage: 0);
  final _defaultColor = Colors.grey; //未选中的颜色
  final _activeColor = Colors.blue; //选中的颜色
  var _currentIndex = 0;
  var appBarTitles;
  DateTime lastPressAt;//上次点击时间

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(), //禁止滑动
          controller: _controller,
          children: <Widget>[
            HomePage(),
            Top_Page(),
           // MovieCategoryPage(),
            Jieshuo_Page(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defaultColor),
                activeIcon: Icon(Icons.home, color: _activeColor),
                title: Text(
                  '首页',
                  style: TextStyle(
                      color: _currentIndex != 0 ? _defaultColor : _activeColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.border_all, color: _defaultColor),
                activeIcon: Icon(Icons.border_all, color: _activeColor),
                title: Text(
                  '排行',
                  style: TextStyle(
                      color: _currentIndex != 1 ? _defaultColor : _activeColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category, color: _defaultColor),
                activeIcon: Icon(Icons.category, color: _activeColor),
                title: Text(
                  '解说',
                  style: TextStyle(
                      color: _currentIndex != 2 ? _defaultColor : _activeColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defaultColor),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                title: Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex != 3 ? _defaultColor : _activeColor),
                ),
              )
            ]),
      ),
      onWillPop: () async {
        if (lastPressAt == null ||
            DateTime.now().difference(lastPressAt) > Duration(seconds: 2)) {
          lastPressAt = DateTime.now();
          Fluttertoast.showToast(msg: "再点击一次可退出应用");

          return false;
        }
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  //防止页面重绘
  bool get wantKeepAlive => true;
}

import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/jieshuo/jieshuo_tab_page.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:android/util/search_delegate.dart';
import 'package:flutter/material.dart';

class Jieshuo_Page extends StatefulWidget {
  @override
  _Jieshuo_PageState createState() => _Jieshuo_PageState();
}

class _Jieshuo_PageState extends State<Jieshuo_Page>
    with TickerProviderStateMixin {
  TabController _controller;
  List<MovieDetailMac> movies;
  int t = 33;

  //MacMovieCategoryDetail macMovieCategoryDetail;
  //int pt; //父类id

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
    fetchData();
  }

  ///防止内存泄露
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        title: Text('精彩解说'),
        backgroundColor: AppColor.white,
        //  app bar 阴影
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed:() => showSearch(context:context, delegate: SearchBarDelegate()),
          ),
        ],
      ),
      body: JieshuoTabPage(t: t),
    );
  }

  // 加载数据
  Future<void> fetchData() async {
    MacApiClient client = MacApiClient();
    var moviesData = await client.getMoviesByCategory(t: t).catchError((e) {
      print(e.toString());
    });
    if (moviesData != null) {
      setState(() {
        movies = MoviestoList.movies2List(moviesData); //fix tab label 空白问题
      });
    }
  }
}

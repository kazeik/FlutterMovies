import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'movie_list_item.dart';
class MovieListView extends StatefulWidget {

  final int typeId;
  final String typeName;
  final String action;

  const MovieListView({Key key, this.typeId, this.action,  this.typeName}) : super(key: key);

  @override
  _MovieListViewState createState() => _MovieListViewState(typeId, typeName,action);
}

class _MovieListViewState extends State<MovieListView> {

  int tytpeId;
  String typeName;
  String action;
  List<MovieDetailMac> movieList;

  // 默认加载 20 条数据
  int pg = 1, pageSize = 5;
  int t;
  bool _loaded = false;

  ScrollController _scrollController = ScrollController(); //listview的控制器

  _MovieListViewState(this.tytpeId, this.typeName,this.action);

  @override
  void initState() { 
    super.initState();
    fetchData();
    // 滚动监听注册
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
          // print('滑动到了最底部');
        setState(() {
          pg = pg+1;
        });
          fetchData();
      }
    });


  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text('$typeName'+'电影'),
          backgroundColor: AppColor.white,
          leading: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_black.png'),
          ),
          elevation: 0,
        ),
        body: _buildBody()
      );
  }

   // 返回上个页面
  back() {
    Navigator.pop(context);
  }

  Widget _buildBody() {
    if (movieList == null) {
      return Center(
        child: CupertinoActivityIndicator(
        ),
      );
    }
    return Container(
        child: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index+1 == movieList.length) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Offstage(
                    offstage: _loaded,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              );
            }
            return  MovieListItem(movieList[index], action);
          },
          controller: _scrollController,
        ),
      );
  }


  Future<void> fetchData() async {
    if (_loaded) {
      return;
    }
    MacApiClient client = new MacApiClient();
    var data = await client.getMoviesByCategory(pt: t,pg: pg,pagesize: pageSize,order: 'vod_time');
    /*switch (action) {
      case 'in_theaters':
        data = await client.getNowPlayingList(start: start, count: count);
        break;
      case 'coming_soon':
        data = await client.getComingList(start: start, count: count);
        break;
      case 'search':
        data = await client.getSearchListByTag(tag: title, start: start, count: count);
        break;
      
    }*/
    setState(() {
      if (movieList == null) {
        movieList = [];
      }
      List<MovieDetailMac> newMovies = MoviestoList.movies2List(data);
      if (newMovies.length == 0) {  
        _loaded = true;
        return;
      }
      newMovies.forEach((movie) {
        movieList.add(movie);
      });
      
//      pg = pg + 1;
    });
  }

   @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
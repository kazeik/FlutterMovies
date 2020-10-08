import 'dart:convert';

import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movie_service.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:android/util/storage.dart';
import 'package:android/util/toast.dart';
import 'package:android/util/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class MoviesFavView extends StatefulWidget {
  List<MovieDetailMac> movies;

  MoviesFavView({Key key, this.movies}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesFavView();
}

class _MoviesFavView extends State<MoviesFavView> {
  @override
  void initState() {
    super.initState();
    getFavListData();
  }

  void deactivate() {
    getFavListData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    /*if (widget.movies == null) {
      return Container(
        child: Text('暂无收藏记录'),
      );
    } else {*/
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text('我的收藏:',
                style: TextStyle(
                    fontSize: fixedFontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkGrey)),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(130),
            child: widget.movies == null || widget.movies.length == 0
                ? Center(
                    child: Text('暂无收藏记录'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildMovieView(context, index, widget.movies);
                    },
                  ),
          )
        ],
      ),
    );
    //}
  }

  _buildMovieView(
      BuildContext context, int index, List<MovieDetailMac> movies) {
    MovieDetailMac movie = movies[index];
    double paddingRight = 0.0;
    if (index == movies.length - 1) {
      paddingRight = 10.0;
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: paddingRight),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (movie.vodId == null) {
                    Toast.show('暂无该收藏记录');
                  } else {
                    AppNavigator.pushMovieDetail(context, movie);
                    //AppNavigator.push(context, ActorDetailView(id: cast.id));
                  }
                },
                child: CachedNetworkImage(
                  height: 100,
                  width: 80,
                  //placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: movie.vodPic,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, d) => Image.asset(
                    "images/icon_nothing.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cancelFavor(movie);
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.black54),
                      child: Icon(
                        Icons.cancel,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 80,
            child: Center(
              child: Text(
                movie.vodName,
                style: TextStyle(
                    fontSize: fixedFontSize(14), color: AppColor.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //获取收藏数据
  Future<void> getFavListData() async {
    try {
      var _favListData = await MovieServices.getList('favMovies');
      var _favList = List.from(_favListData);
      List<MovieDetailMac> moviesFav = MoviestoList.movies2List(_favList);
        
          setState(() {
            widget.movies = moviesFav;
          });
        
    } catch (e) {
      print(e);
    }
  }

  cancelFavor(movie) async {
    List moviesListData = await MovieServices.getList('favMovies');
    try {
      moviesListData.removeWhere((item) {
        return item['vod_id'] == movie.vodId;
      });

      ///不能使用MovieServices.setHistoryData方法
      Storage.setString('favMovies', json.encode(moviesListData));
      getFavListData();
    } catch (e) {
      return [];
    }
    Toast.show('删除收藏成功');
  }
}

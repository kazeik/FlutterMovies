import 'package:android/model/movie_actor_detail.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/movie/actor_detail/actor_detail_view.dart';
import 'package:android/movie/movie_detail/movie_detail_view.dart';
import 'package:android/movie/movie_tag_search_list_view.dart';
import 'package:android/pages/movie_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  // 进入电影详情
  static pushMovieDetail(BuildContext context, MovieDetailMac movie) {
//    AppNavigator.push(context, MovieDetailView(id: id));
    AppNavigator.push(context, MovieDetailView(movie: movie));
  }
  //进入电影搜索列表
  static pushSearchListPage(BuildContext context, String keyword) {
    AppNavigator.push(context, MovieTagSearchListPage(keyWord: keyword));
  }
  // 进入演员详情
  static pushActorDetail(BuildContext context, MovieActorDetail actor) {
    AppNavigator.push(context, ActorDetailView(id: actor.actorId.toString(),));
  }

  // 进入电影列表页面
  /*static pushMovieList(BuildContext context, String title, String action) {
    AppNavigator.push(context, MovieListView(title: title, action: action));
  }
  static pushMovieList(BuildContext context, int typeId, String typeName) {
    AppNavigator.push(context, MovieListView(typeId: typeId,typeName:typeName));
  }*/
  static pushMovieList(BuildContext context, int typeId) {
    AppNavigator.push(
        context,
        MovieCategoryPage(
          pt: typeId,
        ));
  }

// 进入电影榜单列表页面
/*static pushMovieTopList(BuildContext context, String title, String subTitle, String action) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return MovieTopListView(action: action, title: title, subTitle: subTitle,);
    }));
  }*/

// 进入 webview
/*static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return WebViewScene(url: url, title: title);
    }));
  }*/

// 进入登陆页面
/*static pushLogin(BuildContext context) {
     Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
*/

}

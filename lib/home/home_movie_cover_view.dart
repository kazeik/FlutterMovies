import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/app/rating_view.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/screen.dart';
import 'package:android/home/movie_cover_image.dart';
import 'package:flutter/material.dart';

class HomeMovieCoverView extends StatelessWidget {
  final MovieDetailMac movie;
  final int num; //一行放的电影数

  HomeMovieCoverView(this.movie, this.num);

  @override
  Widget build(BuildContext context) {
    // 单个电影的宽度
    // 一行放置 2个 电影
    var width = (Screen.width - 15 * 4) / 2;

    return GestureDetector(
      onTap: () {
        //AppNavigator.pushMovieDetail(context, movie.id);
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(
              movie.vodPic,
              width: width,
              height: width / 0.75,
              movie: movie,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              movie.vodName,
              overflow: TextOverflow.ellipsis,
              //style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new StaticRatingBar(
                    size: 13.0,
                    rate: double.parse(movie.vodScore) / 2,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  movie.vodScore.toString(),
                  style: TextStyle(color: AppColor.grey, fontSize: 12.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

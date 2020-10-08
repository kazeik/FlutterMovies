import 'package:android/app/app_color.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/screen.dart';
import 'package:flutter/material.dart';

class MovieComingView extends StatelessWidget {
  final List<MovieDetailMac> movie;

  MovieComingView(this.movie);

  @override
  Widget build(BuildContext context) {
    // 单个电影的宽度
    // 一行放置 3 个 电影
    var width = (Screen.width - 15 * 4) / 3;

    return GestureDetector(
      onTap: () {
       // AppNavigator.pushMovieDetail(context, movie.id);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //MovieCoverImage(movie.images.small, width: width, height: width / 0.75,),
            SizedBox(height: 5,),
            Text(
              '电影标题',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(height: 3,),
            Text(
              'XXXX人想看',
              style: TextStyle(fontSize: 10, color: AppColor.grey),
            ),
            SizedBox(height: 3,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 0.5),
                  borderRadius: BorderRadius.circular(2.0)),
              child: Text('年月日'),
              //Text(movie.mainlandPubdate.split('-')[1]+'月'+movie.mainlandPubdate.split('-')[2] + '日', style: TextStyle(color: Colors.red, fontSize: 8.0),),
            ),
          ],
        ),
      ),
    );
  }
}
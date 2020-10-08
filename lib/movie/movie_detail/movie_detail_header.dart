import 'package:android/app/app_color.dart';
import 'package:android/app/rating_view.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/movie/movie_detail/moviedetail_cover_image.dart';
import 'package:android/util/screen.dart';
import 'package:android/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetailMac movie;
  final Color coverColor;

  const MovieDetailHeader({this.movie, this.coverColor});

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var height = 218.0 + Screen.topSafeHeight;

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(
                 movie.vodPic),
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(color: coverColor, width: width, height: height),
          ),
          buildContent(context),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var width = Screen.width;
    var height = 218.0 + Screen.topSafeHeight;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.fromLTRB(15, 54 + Screen.topSafeHeight, 10, 0),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    color: Color(0x66000000),
                    offset: new Offset(1.0, 1.0),
                    blurRadius: 5.0,
                    spreadRadius: 2)
              ],
            ),
            child: MovieCoverImage(
                movie.vodPic,
                width: 100,
                height: 133,movie: movie,),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.vodName,
                  style: TextStyle(
                      fontSize: fixedFontSize(20),
                      color: AppColor.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
               /* Row(
                  children: <Widget>[
                    Text(
                      movie.vodName,
                      style: TextStyle(
                          fontSize: fixedFontSize(16),
                          color: AppColor.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      movie.vodYear != null ? '(${movie.vodYear})' : '(未知)',
                      style: TextStyle(
                          fontSize: fixedFontSize(16),
                          color: AppColor.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),*/
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new StaticRatingBar(
                      size: 13.0,
                      rate: double.parse(movie.vodScore) / 2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      movie.vodScore.toString(),
                      style: TextStyle(
                          color: AppColor.white, fontSize: fixedFontSize(12)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${movie.vodArea}/${movie.vodClass}/ 上映时间：${movie.vodYear}/${movie.vodDirector}/${movie.vodActor}',
                  style: TextStyle(
                      color: AppColor.white, fontSize: fixedFontSize(12)),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

/*String actor2String(List<MovieActor> actors) {
    StringBuffer sb = new StringBuffer();
    actors.forEach((actor) {
      sb.write(' ${actor.name} ');
    });
    return sb.toString();
  }

  String list2String(List list) {
    StringBuffer sb = new StringBuffer();
    list.forEach((item) {
      sb.write(' $item ');
    });
    return sb.toString();
  }

  String countries2String(List countries) {
    StringBuffer sb = new StringBuffer();
    countries.forEach((country) {
      sb.write('$country ');
    });
    return sb.toString();
  }*/
}

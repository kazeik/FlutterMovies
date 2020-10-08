import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/app/rating_view.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/movie/actor_detail/movie_cover_image.dart';
import 'package:android/util/utility.dart';
import 'package:flutter/material.dart';
// 演员相关影视
class ActorDetailWorks extends StatelessWidget {
  
  final List<MovieDetailMac> works;

  const ActorDetailWorks(this.works);


  @override
  Widget build(BuildContext context) {

    return Container(
      // padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('影视作品',
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: AppColor.white
              )),
          ),
          SizedBox(height: 20,),
          SizedBox.fromSize(
            size: Size.fromHeight(180),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: works.length,
              itemBuilder: (BuildContext context, int index) {
              return _buildWorks(context, index);
             },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorks(BuildContext context, int index) {
    double width = 90;
    MovieDetailMac work  =works[index];
    double paddingRight = 0;
    if (index ==works.length-1) {
      paddingRight = 15;
    }
    return  GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, work);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: paddingRight),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(work.vodPic, width: width, height: width / 0.75,),
            SizedBox(height: 5,),
            Text(
              work.vodName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: AppColor.white),
              maxLines: 1,
            ),
            SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new StaticRatingBar(size: 12.0,rate:double.parse( work.vodScore)),
                SizedBox(width: 5,),  
                Text(work.vodScore.toString(),style: TextStyle(color: AppColor.white, fontSize: 10.0),)
              ],
            ),
          ],
        ),
      ),
    );
  }

}

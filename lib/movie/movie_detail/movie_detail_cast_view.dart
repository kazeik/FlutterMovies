import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_actor_detail.dart';
import 'package:android/movie/actor_detail/actor_detail_view.dart';
import 'package:android/util/toast.dart';
import 'package:android/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailCastView extends StatelessWidget {
  final List<MovieActorDetail> actors;

  const MovieDetailCastView(this.actors);

  @override
  Widget build(BuildContext context) {
    List<MovieActorDetail> casts = [];

    actors.forEach((actor) {
      casts.add(actor);
    });

    if (actors != null && actors.length != 0) {
      return Container(
        // padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('演职员:',
                  style: TextStyle(
                      fontSize: fixedFontSize(18),
                      fontWeight: FontWeight.bold,
                      color: AppColor.white)),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(130),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actors.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCastView(context, index, casts);
                },
              ),
            )
          ],
        ),
      );
    }else{
      return Container();
    }
  }

  _buildCastView(
      BuildContext context, int index, List<MovieActorDetail> casts) {
    MovieActorDetail cast = casts[index];
    double paddingRight = 0.0;
    if (index == casts.length - 1) {
      paddingRight = 15.0;
    }
    return Container(
      margin: EdgeInsets.only(left: 5, right: paddingRight),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (cast.actorId == null) {
                Toast.show('暂无该演员信息');
              } else {
                AppNavigator.push(context, ActorDetailView(id: cast.actorId.toString()));
              }
            },
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(cast.actorPic),
              radius: 40.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 80,
            child: Center(
              child: Text(
                cast.actorName,
                style: TextStyle(
                    fontSize: fixedFontSize(14), color: AppColor.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:android/model/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCoverImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final MovieDetailMac movie;

  MovieCoverImage(this.imgUrl, {this.width, this.height, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Hero(
          tag: '${movie.vodId}',
          child: CachedNetworkImage(
            //placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
            errorWidget: (context, url, d) => Image.asset(
              "images/icon_nothing.png",
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    );
  }
}

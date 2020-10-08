import 'package:android/model/movie_detail.dart';
import 'package:flutter/material.dart';

import 'home_section_view.dart';
import 'home_movie_cover_view.dart';

class MovieThreeGridView extends StatelessWidget {
  final List<MovieDetailMac> movies;
  final String typeName; //分类名称
  final int typeId; //分类id

  MovieThreeGridView({this.movies, this.typeName, this.typeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HomeSectionView(
            typeName: typeName,
            typeId: typeId,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Wrap(
                spacing: 15,
                runSpacing: 20,
                children: movies
                    .map((movie) => HomeMovieCoverView(movie, 2))
                    .toList(),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          )
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/toppage/movie_detail_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieItem extends StatefulWidget {
  final MovieDetailMac movie;
  final int index;

  const MovieItem({Key key, this.movie, this.index}) : super(key: key);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Color pageColor = AppColor.darkGrey;

  @override
  void initState() {
    super.initState();
    fetchDataColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, widget.movie);
        //Fluttertoast.showToast(msg: "详情页还没做哦!~~~~");
        //Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(url:'http://www.baidu.com')));
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          child: MovieDetailItem(
            movie: widget.movie,
            coverColor: pageColor,
            index: widget.index,
          ),
        ),
      ),
    );
  }

  Future<void> fetchDataColor() async {
    try {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(this.widget.movie.vodPic),
      );
      if (mounted) {
        setState(() {
          if (paletteGenerator.darkVibrantColor != null) {
            pageColor = paletteGenerator.darkVibrantColor.color;
          } else {
            pageColor = Color(0xff35374c);
          }
          // pageColor =paletteGenerator.dominantColor?.color;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

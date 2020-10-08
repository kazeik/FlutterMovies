import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';


// ignore: must_be_immutable
class NewsBannerView extends StatelessWidget {
  List<MovieDetailMac> moviesDetails;
  NewsBannerView(this.moviesDetails);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarouselSlider(
        height: Screen.height-(Screen.topSafeHeight+Screen.bottomSafeHeight+200),
        items: moviesDetails.map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  //AppNavigator.pushWeb(context, banner.news.link,banner.news.title);
                  AppNavigator.pushMovieDetail(context, movie);
                },
                child: Container(
                    //width: Screen.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: Screen.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(movie.vodPic),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: Container(
                            width: Screen.width,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: Screen.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movie.vodName,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(movie.vodContent,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColor.white,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          );
        }).toList(),
        aspectRatio: 2,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
      ),
    );
  }
}

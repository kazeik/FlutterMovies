import 'package:android/model/movie_detail.dart';
//movies转换为List
class MoviestoList{
  static List<MovieDetailMac> movies2List(sliders) {
    List<MovieDetailMac> moviesList =[];
    sliders.forEach((data){
      moviesList.add(MovieDetailMac.fromJson(data));
    });
    return moviesList;
  }

}
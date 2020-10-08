

import 'movie_detail.dart';

class MoviesListMac {
  List<MovieDetailMac> movieslist;
  MoviesListMac({this.movieslist});
  MoviesListMac.fromJson(Map json) {
    var moviesJson = json as List;
    movieslist = moviesJson.map((i)=>MovieDetailMac.fromJson(i)) as List<MovieDetailMac> ;
  }
}

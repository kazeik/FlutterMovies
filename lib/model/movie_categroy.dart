import 'movie_category_detail.dart';
//所有子类模型
class MacMovieCategroy {
  Map<dynamic, MacMovieCategoryDetail> categroys;

  MacMovieCategroy({this.categroys});

  MacMovieCategroy.fronjson(Map json) {
    var categroysJson = json as Map;
    categroys = categroysJson
        .map((k, v) => MapEntry(k, MacMovieCategoryDetail.fromJson(v)));
  }
}

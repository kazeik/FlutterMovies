import 'package:android/model/movie_category_detail.dart';
import 'package:android/model/movie_detail.dart';
//types分类转换为List
class TypesToList{
  static List<MacMovieCategoryDetail> typess2List(types) {
    List<MacMovieCategoryDetail> typesList=[];
    types.forEach((data){
      typesList.add(MacMovieCategoryDetail.fromJson(data));
    });
    return typesList;
  }

}
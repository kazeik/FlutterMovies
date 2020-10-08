import 'package:android/util/toast.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MacApiClient {
  static const String webUrl = 'https://www.jinrikanpian.net/';
  static const String baseUrl = webUrl + 'appapi.php';
  var dio = MacApiClient.createDio();

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: webUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
/*      contentType: 'json',
        queryParameters: {
          //"apikey":apiKey
        }*/
    );
    return Dio(options);
  }

  ///首页幻灯片 指定leve=9 默认5条数据
  Future<dynamic> getHomeSliders({leve = 9, pagesize = 5}) async {
    return getMoviesByCategory(leve: leve, pagesize: pagesize);
  }

  ///获取禁止的urls,在Webview中拦截
  Future<dynamic> getBanUrls() async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/banUrls');
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  ///首页网格按父类推荐视频
  ///指定leve=8 默认6条数据
  Future<dynamic> getHomeGridMoviesBypt(int pt,
      {leve = 8, pagesize = 6}) async {
    return getMoviesByCategory(pt: pt, leve: leve, pagesize: pagesize);
  }

  ///更新电影浏览次数

  Future<dynamic> updateMovieHits(int mid, int id, String type) async {
    Response<Map> response;
    try {
      response = await dio.get('ajax/hits',
          queryParameters: {'mid': mid, 'id': id, 'type': type});
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  ///获取启动页广告
  Future<dynamic> getSplash() async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/getSplash');
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  ///获取更新信息
  Future<dynamic> getAppupgradeInfo() async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/appupgradeInfo');
    } catch (e) {
      //Toast.show('网络异常');
      return null;
    }
    return response.data['upgradeinfo'];
  }

  ///获取单个电影详情
  Future<dynamic> getMovieDetails(String id) async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/vod/?ac=detail&ids=' + id);
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'][0];
  }

  ///获取电影列表
  //pt 父类
  //t 类别id
  //pg=页码
  //wd=搜索关键字
  //h=几小时内的数据
  //pagesize一页展示多少条
  //leve指定推荐数1-9
  //order按照什么排列，比如vod_id是按照id排列,vod_time按照时间排列，vod_hits_month按照当月点击数排行
  //例如：/api/vod/?ac=detail&t=1&pg=5   分类ID为1的列表数据第5页
  //api按照更新时间
  Future<dynamic> getMoviesByCategory(
      {int pt,
      int t,
      int pg,
      String wd,
      int h,
      int pagesize,
      int leve,
      String order}) async {
    Response<Map> response;
    try {
      response =
          await dio.get('appapi.php/api/vod/?ac=detail', queryParameters: {
        'pt': pt,
        't': t,
        'pg': pg,
        'wd': wd,
        'h': h,
        'pagesize': pagesize,
        'leve': leve,
        'order': order
      });
    } catch (e) {
      Toast.show(e.toString());
      return null;
    }
    return response.data['list'];
  }

  ///获取所有分类数据，不包括父类
  Future<dynamic> getSubcategoryAll() async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/vodCategoryAll');
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'];
  }

  ///指定父类，获取下面所有子类
  Future<dynamic> getSubcategoryByPcategory({int pt}) async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/getSubcategoryByPcategory',
          queryParameters: {'pt': pt});
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'];
  }

  ///获取所有父类不包括子类
  Future<dynamic> getPcategory() async {
    Response<Map> response;
    try {
      response = await dio
          .get('appapi.php/api/getPcategory', queryParameters: {'pt': 0});
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'];
  }

  ///根据名字获取演员详情，支持多个名称，用,分割
  Future<dynamic> getActorsDetail(String wd) async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/actor/?ac=detail&wd=' + wd);
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'];
  }

  ///根据ID获取演员详情，支持多个名称，用,分割
  Future<dynamic> getActorsDetailByIds(String ids) async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/actor/?ac=detail&ids=' + ids);
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data['list'][0];
  }

  ///根据演员名获取电影列表
  Future<dynamic> getMoviesByActor(
      {int pg = 1, int pagesize = 10, String actor}) async {
    Response<Map> response;
    try {
      response = await dio.get('appapi.php/api/vod/?ac=detail',
          queryParameters: {'pg': pg, 'pagesize': pagesize, 'actor': actor});
    } catch (e) {
      Toast.show(e.toString());
      return null;
    }
    return response.data['list'];
  }
}

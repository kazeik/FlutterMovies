import 'dart:convert';
import 'Storage.dart';

class MovieServices {
  static setData(key, value) async {
    /**
     * 1.获取本地存储里面的数据。(searchList)
     * 2.判断本地存储是否有数据
     * 2.1如果有数据：
     *  1.读取本地存储的数据。
     * 2.判断本地存储中有没有当前数据；
     * 3.如果有不做操作
     * 如果没有当前数据，本地存储的数据和当前数据拼接后重新写入。
     * 2.2如果没有数据：
     * 直接把当前数据放在数组中写入到本地存储。
     *
     *
     *  */
    try {
      List moviesListData = json.decode(await Storage.getString(key));

      var hasData = moviesListData.any((v) {
        return v == value;
      });
      if (!hasData) {
        moviesListData.add(value);
        await Storage.setString(key, json.encode(moviesListData));
      }

      /*var hasData = moviesListData.indexWhere((item) {
        //return item['vod_id'] == widget.movie.vodId;
        return item['vod_id'] == value['vod_id'];
      });
      if (hasData == -1) {
        moviesListData.add(value);
        await Storage.setString(key, json.encode(moviesListData));
      } else {
        moviesListData[hasData] = value;
        await Storage.setString(key, json.encode(moviesListData));
      }*/
    } catch (e) {
      List tempList = new List();
      tempList.add(value);
      await Storage.setString(key, json.encode(tempList));
    }
  }

  static getList(key) async {
    try {
      List moviesListData = json.decode(await Storage.getString(key));
      return moviesListData;
    } catch (e) {
      return [];
    }
  }

  static removeList(key) async {
    await Storage.remove(key);
  }
}

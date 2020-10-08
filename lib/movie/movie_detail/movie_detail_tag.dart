import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/util/search_delegate.dart';
import 'package:android/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailTag extends StatelessWidget {
  final List tags;

  MovieDetailTag(this.tags);

  @override
  Widget build(BuildContext context) {
    if (tags == null || tags.length <= 1) {
      return Container(
        height: 1,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: new Border.all(color: Colors.white, width: 0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('相关标签:',
                  style: TextStyle(
                      fontSize: fixedFontSize(15),
                      fontWeight: FontWeight.bold,
                      color: AppColor.white)),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(30.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildTag(context, index);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTag(BuildContext context, int index) {
    String tag = tags[index];
    double paddingRight = 0;
    if (index == tags.length - 1) {
      paddingRight = 10;
    }
    return GestureDetector(
        onTap: () {
          //showSearch(context:context, delegate: SearchBarDelegate(keyword: tag));
          AppNavigator.pushSearchListPage(context, tag);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(left: 5, right: paddingRight),
            decoration: BoxDecoration(
                color: Color(0x66000000),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(tag,
                    style: TextStyle(
                        fontSize: fixedFontSize(15), color: AppColor.white)),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColor.white,
                ),
              ],
            )));
  }
}

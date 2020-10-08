import 'package:android/app/app_color.dart';
import 'package:android/util/storage.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

///处理App更新，安卓和Ios都是跳转到应用市场更新
class AppUpgrade extends StatelessWidget {
  final int id;
  final String title;
  final String newFeature;
  final String versionCode;
  final String versionName;
  final String packageName;
  final String iosAppId;
  final String apkUrl;

  const AppUpgrade(
      {Key key,
      this.id,
      this.title,
      this.newFeature,
      this.versionCode,
      this.versionName,
      this.packageName,
      this.apkUrl,
      this.iosAppId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        /*width: 100,
        height: 200,*/
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //_buildBar(context),
            _buildTitle(),
            _buildContent(),
            _buildFooter(context),
          ],
        ),
      );
  }

  Widget _buildTitle() {
    return Center(
        child: Text(
      title,
      style: TextStyle(color: Color(0xff5CC5E9), fontSize: 18),
    ));
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        newFeature,
        style: TextStyle(color: AppColor.darkGrey, fontSize: 13),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildFooter(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: AppColor.grey),
              child: Text('取消',
                  style: TextStyle(color: Colors.black45, fontSize: 12)),
            ),
          ),
          InkWell(
            onTap: () {
              LaunchReview.launch(
                  androidAppId: packageName, iOSAppId: iosAppId);
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.lightBlue),
              child: Text('去应用市场更新',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}

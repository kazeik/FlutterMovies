import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/my/movies_fav_view.dart';
import 'package:android/my/movies_history_view.dart';
import 'package:android/my/settiing_page.dart';
import 'package:android/util/screen.dart';
import 'package:android/util/utils.dart';
import 'package:android/widgets/CustomPopupMenuButton.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  List<MovieDetailMac> movies;

  MyPage({Key key, this.movies}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  //String text;
  //TabController _tabController;

  @override
  void initState() {
    // _tabController = TabController(vsync: this, length: 2);
    widget.movies = [];
    // getFavListData();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                '我的',
                style: TextStyle(color: AppColor.white, fontSize: 18),
              ),
              brightness: Brightness.dark,
              pinned: true,
              snap: false,
              backgroundColor: AppColor.darkGrey,
              forceElevated: boxIsScrolled,
              elevation: 0,
              floating: true,
              expandedHeight: 160.0,
              actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
              actions: _buildActions(),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(color: AppColor.darkGrey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 48,
                        child: Image.asset(Utils.getImgPath('icon')),
                        //backgroundImage:CachedNetworkImageProvider(myAvatarUrl),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            MoviesHistoryView(
              movies: widget.movies,
            ),
            MoviesFavView(movies: widget.movies),
          ],
        ));
  }

  List<Widget> _buildActions() => <Widget>[
        //CustomPopupMenuButton(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(context),
                ));
          },
          child: Icon(Icons.settings_applications),
        )
      ];
}

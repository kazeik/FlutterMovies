import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/home/home_news_banner_view.dart';
import 'package:android/model/movie_category_detail.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:android/util/storage.dart';
import 'package:android/util/type_to_list.dart';
import 'package:android/widgets/web_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'movie_three_grid_view.dart';

class HomeListView extends StatefulWidget {
  HomeListView();

  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 0;
  List<MovieDetailMac> slidersList;
  List<MovieDetailMac> dianyingList;
  List<MovieDetailMac> dianshiList;
  List<MovieDetailMac> zongyiList;
  List<MovieDetailMac> dongmansList;
  List<MacMovieCategoryDetail> pcategoryList = [];
  List widgets;
  var nowPlayingList, comingList;
  bool isAgree = Storage.getBool('isAgree', defValue: false);

  @override
  void initState() {
    super.initState();
    fetchData();
    if (isAgree == false) {
      Future.delayed(Duration.zero, () {
        showDialog(context: context, builder: (ctx) => _buildDialog());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (slidersList == null) {
      return new Center(
        child: new CupertinoActivityIndicator(),
      );
    } else {
      return Container(
        child: RefreshIndicator(
          color: AppColor.primary,
          onRefresh: fetchData,
          child: ListView(
            addAutomaticKeepAlives: true,
            // 防止 children 被重绘，
            cacheExtent: 3000,
            children: <Widget>[
              //Text(slidersList.toString()),
              new NewsBannerView(slidersList),
              new MovieThreeGridView(
                movies: dianyingList,
                typeName: '电影',
                typeId: 1,
              ),

              new MovieThreeGridView(
                  movies: dianshiList, typeName: '电视剧', typeId: 2),
              new MovieThreeGridView(
                  movies: zongyiList, typeName: '综艺', typeId: 3),
              new MovieThreeGridView(
                  movies: dongmansList, typeName: '动漫', typeId: 4),
              /*new NewsBannerView(newsList),
                new MovieThreeGridView(nowPlayingList, '影院热映', 'in_theaters'),
                new MovieThreeGridView(comingList, '即将上映', 'coming_soon'),
                new MovieTopScrollView(title: '电影榜单'),
                //new MovieClassifyView(title: '分类浏览'),
                new MovieRecommendationView(title: '猜你喜欢',),*/
            ],
          ),
        ),
      );
    }
  }

  // 加载数据
  Future<void> fetchData() async {
    MacApiClient client = MacApiClient();
    //http://videocms.com/appapi.php/api/vod/?ac=detail&leve=1&pagesize=5&pg=2
    var sliders = await client.getHomeSliders(); //获取推荐值为9的电影数据5条数据
    var allPcategory = await client.getPcategory(); //所有父类
    var hitsMonthDianying = await client.getHomeGridMoviesBypt(1);
    var hitsMonthDianshi = await client.getHomeGridMoviesBypt(2);
    var hitsMonthZongyi = await client.getHomeGridMoviesBypt(3);
    var hitsMonthDongman = await client.getHomeGridMoviesBypt(4);

    if (mounted) {
      setState(() {
        pcategoryList = TypesToList.typess2List(allPcategory);
        slidersList = MoviestoList.movies2List(sliders);
        dianyingList = MoviestoList.movies2List(hitsMonthDianying);
        dianshiList = MoviestoList.movies2List(hitsMonthDianshi);
        zongyiList = MoviestoList.movies2List(hitsMonthZongyi);
        dongmansList = MoviestoList.movies2List(hitsMonthDongman);
      });
    }
  }

  Widget _buildDialog() => WillPopScope(
        child: Dialog(
          backgroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 80,
            child: DeleteDialog(),
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        },
      );

  // 保持页面状态
  @override
  bool get wantKeepAlive => true;
}

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 300,
      //height: 800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //_buildBar(context),
          _buildTitle(),
          _buildContent(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
        child: Text(
      '欢迎使用',
      style: TextStyle(color: Color(0xff5CC5E9), fontSize: 18),
    ));
  }

  Widget _buildContent(context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '    感谢您选择《今日看片》App！ ,'
              ' 我们非常重视您的隐私保护和个人信息保护。为了更好的保障您的个人权益，在您使用我们本产品前，请务必审阅《用户许可和隐私协议》和《今日看片版权声明》的所有条款尤其是：'
              '    1，我们对于您的个人信息的收集、保存、使用、对外提供、保护等规则条款，以及您的用户权力等条款。'
              '    2，约定我们的限制责任、免责条款。'
              '    3，其他颜色、下划线或者加粗进行标注的重要条款。'
              ' 如果您对以上协议有任何疑问，可以通过应用设置页面反馈功能与我们联系。'
              ' 您点击“同意，继续使用”，即表示您已经阅读完毕并同意以上协议全部内容。'
              '如您同意以上协议内容，请点击“同意，继续使用”，开始使用我们的产品和服务',
              style: TextStyle(color: AppColor.darkGrey, fontSize: 13),
              textAlign: TextAlign.justify,
            ),
            Container(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebScaffold(
                        title: '今日看片版权声明',
                        url: 'http://www.jinrikanpian.net/app/copyright.html',
                      ),
                    ));
              },
              child: Text(
                '《今日看片版权声明》',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebScaffold(
                        title: '隐私保护指引',
                        url:
                            'http://www.jinrikanpian.net/app/androidPermission.html',
                      ),
                    ));
              },
              child: Text(
                '《今日看片用户许可和隐私协议》',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ));
  }

  Widget _buildFooter(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () {
              _exitApp();
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: AppColor.grey),
              child: Text('不同意，退出',
                  style: TextStyle(color: Colors.black45, fontSize: 12)),
            ),
          ),
          InkWell(
            onTap: () {
              Storage.setBool('isAgree', true);
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.lightBlue),
              child: Text('同意，继续使用',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  /* _buildBar(context) => Container(
        height: 30,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 10, top: 5),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.close,
            color: Color(0xff82CAE3),
          ),
        ),
      );*/

  _exitApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

import 'package:android/app/api_client.dart';
import 'package:android/app/app_color.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/app/rating_view.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:android/util/screen.dart';
import 'package:android/widgets/loading_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGE_SIZE = 10;

class MovieCategoryTabPage extends StatefulWidget {
  final int t;

  const MovieCategoryTabPage({Key key, this.t}) : super(key: key);

  @override
  _MovieCategoryTabPageState createState() => _MovieCategoryTabPageState();
}

class _MovieCategoryTabPageState extends State<MovieCategoryTabPage>
    with AutomaticKeepAliveClientMixin {
  List<MovieDetailMac> movieDetailMacs = [];
  int pageIndex = 1;
  bool _loading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //print('滑动到了最底部${_scrollController.position.pixels}');

        _loadData(loadMore: true);
      }
    });
    _loadData(loadMore: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        /*child: RefreshIndicator(
          onRefresh: _handleRefresh,*/
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 4,
              itemCount: movieDetailMacs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => _MovielItem(
                index: index,
                movie: movieDetailMacs[index],
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            )),
        //),
      ),
    );
  }

  Future _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    MacApiClient client = MacApiClient();
    var movies = await client.getMoviesByCategory(
        t: widget.t, pg: pageIndex, pagesize: PAGE_SIZE, order: 'vod_level');
    List<MovieDetailMac> movieDetailMacsList = MoviestoList.movies2List(movies);

    setState(() {
      _loading = false;
      movieDetailMacs.addAll(movieDetailMacsList);

      ///注意!!!!是追加，不是直接赋值
    });
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> _handleRefresh() async {
    _loadData(loadMore: false);
    return null;
  }
}

class _MovielItem extends StatelessWidget {
  //final TravelItem item;
  final MovieDetailMac movie;
  final int index;
  final double width = (Screen.width - 10) / 2;
  final double height =
      (Screen.height - Screen.bottomSafeHeight - Screen.bottomSafeHeight) / 3;

  _MovielItem({Key key, this.movie, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
        //Fluttertoast.showToast(msg: "详情页还没做哦!~~~~");
        //Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(url:'http://www.baidu.com')));
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: _itemImage(),
              ),
              Center(
                //padding: EdgeInsets.all(4),
                child: Text(
                  movie.vodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              //_infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Hero(
          tag: '${movie.vodId}',
          child: Container(
            width: width,
            height: height,
            child: CachedNetworkImage(
              //placeholder: (context, url) => CircularProgressIndicator(),
              placeholder: (context, url) => Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
              imageUrl: movie.vodPic,
              fit: BoxFit.cover,
              errorWidget: (context, url, d) => Image.asset(
                "images/icon_nothing.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        //Image.network('http://www.jinrikanpian.net/' + movie.vodPic),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new StaticRatingBar(
                    size: 13.0,
                    rate: double.parse(movie.vodScore) / 2,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.vodScore.toString(),
                    style: TextStyle(color: AppColor.grey, fontSize: 12.0),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

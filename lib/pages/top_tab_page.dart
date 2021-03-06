import 'package:android/app/api_client.dart';
import 'package:android/app/app_navigator.dart';
import 'package:android/model/movie_detail.dart';
import 'package:android/toppage/movie_detail_item.dart';
import 'package:android/toppage/movie_item.dart';
import 'package:android/util/movies_to_list.dart';
import 'package:android/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGE_SIZE = 20;

class TopTabPage extends StatefulWidget {
  final int pt;

  const TopTabPage({Key key, this.pt}) : super(key: key);

  @override
  _TopTabPageState createState() => _TopTabPageState();
}

class _TopTabPageState extends State<TopTabPage>
    with AutomaticKeepAliveClientMixin {
  List<MovieDetailMac> movieDetailMacs = [];
  int pageIndex = 1;
  bool _loading = true;
  ScrollController _scrollController = ScrollController();
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //print('滑动到了最底部${_scrollController.position.pixels}');

        _loadData(loadMore: true);
      }
    });*/
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
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child:  ListView.builder(
              controller: _scrollController,
              itemCount: movieDetailMacs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => MovieItem(
                index: index,
                movie: movieDetailMacs[index],
              ),
            ),
            /*child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 1,
              itemCount: movieDetailMacs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => MovieItem(
                index: index,
                movie: movieDetailMacs[index],
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            ),*/
          ),
        ),
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
        pt: widget.pt,
        pg: pageIndex,
        pagesize: PAGE_SIZE,
        order: 'vod_hits_month'); //排行榜默认按月点击数
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

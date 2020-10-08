import 'package:android/movie/movie_search_list_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  //final String keyword;
  final String searchFieldLabel='请输入关键词';

  //SearchBarDelegate({this.keyword});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    //return MovieSearchListView(query, 'search');
    if (query.isEmpty) {
      return Center(
        child: Text('请输入关键词'),
      );
    } else {
      return MovieSearchListPage(
        keyWord: query,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }

}

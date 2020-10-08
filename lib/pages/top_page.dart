import 'package:android/app/api_client.dart';
import 'package:android/model/movie_category_detail.dart';
import 'package:android/pages/top_tab_page.dart';
import 'package:android/util/type_to_list.dart';
import 'package:flutter/material.dart';
import 'package:tencent_ad/native_template.dart';
import 'package:underline_indicator/underline_indicator.dart';

class Top_Page extends StatefulWidget {
  @override
  _Top_PageState createState() => _Top_PageState();
}

class _Top_PageState extends State<Top_Page> with TickerProviderStateMixin {
  TabController _controller;
  List<MacMovieCategoryDetail> tabs = [];

  //MacMovieCategoryDetail macMovieCategoryDetail;
  //int pt; //父类id

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    fetchData();
  }

  ///防止内存泄露
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10),
          child: Center(
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(10, 0, 5, 5),
                indicator: UnderlineIndicator(
                    strokeCap: StrokeCap.round,
                    borderSide: BorderSide(
                      color: Color(0xff2fcfbb),
                      width: 3,
                    ),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: tabs.map<Tab>((MacMovieCategoryDetail tab) {
                  return Tab(
                    child: Text(
                      tab.typeName,
                      style: TextStyle(fontSize: 15),
                    ),
                    //text: tab.typeName,
                  );
                }).toList()),
          ),
        ),
        Flexible(
          child: TabBarView(
              controller: _controller,
              children: tabs.map((MacMovieCategoryDetail tab) {
                return TopTabPage(
                  pt: tab.typeId,
                );
              }).toList()),
        ),
      ]),
    );
  }

  // 加载数据
  Future<void> fetchData() async {
    MacApiClient client = MacApiClient();
    var types = await client.getPcategory().catchError((e) {
      print(e.toString());
    });
    if (types != null&&mounted) {
      setState(() {
        tabs = TypesToList.typess2List(types);
        _controller = TabController(
            length: tabs.length, vsync: this); //fix tab label 空白问题
      });
    }
  }
}

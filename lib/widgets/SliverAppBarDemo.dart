import 'package:flutter/material.dart';

class SliverAppBarDemo extends StatefulWidget {
  @override
  _SliverAppBarDemoState createState() => _SliverAppBarDemoState();
}

class _SliverAppBarDemoState extends State<SliverAppBarDemo> {
  bool _floating = false;
  bool _pinned = false;
  bool _snap = false;

  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTool(),
        Container(
          height: 300,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(),
              _buildSliverFixedExtentList()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    print(_floating);
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      floating: _floating,
      pinned: _pinned,
      snap: _snap,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.star_border,
        color: Colors.white,
      ),
    )
  ];

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
    itemExtent: 60,
    delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          color: data[index],
          child: Text(
            colorString(data[index]),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ),
        childCount: data.length),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('floating'),
            Switch(
                value: _floating,
                onChanged: (v) {
                  if(_snap&&!v){
                    _snap =false;
                  }
                  setState(() => _floating = v);
                }),
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('pinned'),
            Switch(
                value: _pinned,
                onChanged: (v) => setState(() => _pinned = v)),
          ],
        )       ,Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('snap'),
            Switch(
                value: _snap,
                onChanged: (v) {
                  if(_floating){
                    setState(() => _snap = v);
                  }

                }),
          ],
        )
      ],
    );
  }
}
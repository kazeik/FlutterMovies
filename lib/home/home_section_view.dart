import 'package:android/app/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeSectionView extends StatelessWidget {
  final int typeId;//分类ID
  final String typeName;//分类名称

  HomeSectionView({this.typeId,this.typeName});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$typeName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              Container(
                width: 80,
                height: 2,
                color: Colors.black,
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.pushMovieList(context, typeId);
              /*if (action == 'search') {
               // AppNavigator.push(context, MovieClassifyListView());
              } else {
               // AppNavigator.pushMovieList(context, title, action);
              }*/
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('更多...',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                SizedBox(width: 3,),
                Icon(CupertinoIcons.forward, size: 14,),
              ],
            )
          )
        ],
      )
    );
  }
}
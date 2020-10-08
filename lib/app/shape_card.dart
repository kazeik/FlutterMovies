import 'package:android/util/pather.dart';
import 'package:flutter/material.dart';

class ShapeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffB3FE65),
      elevation: 6,
      shape: StarShapeBorder(),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: Text("Card", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class StarShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) =>
      Pather.create.nStarPath(9, 50, 40, dx: 50, dy: 50);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}

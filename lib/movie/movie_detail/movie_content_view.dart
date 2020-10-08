import 'package:flutter/material.dart';

class MovieContentView extends StatefulWidget {
  final String text;

  const MovieContentView({Key key, this.text}) : super(key: key);
  @override
  createState() => _MovieContentViewState();
}

class _MovieContentViewState extends State<MovieContentView> {

  bool expand = false;
  int maxLines =2;


  final style = TextStyle(fontSize: 15, color: Colors.white, /*shadows: [
    Shadow(
        color: Colors.white, offset: Offset(1,1)
    )
  ]*/);

  @override
  build(context) => Container(
    decoration: BoxDecoration(
        color: Colors.cyanAccent.withAlpha(8),
        borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
    padding: EdgeInsets.all(15),
    child: LayoutBuilder(builder: (context, size) {

      final painter = TextPainter(
        text: TextSpan(text: widget.text, style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      );
      painter.layout(maxWidth: size.maxWidth);
      if (!painter.didExceedMaxLines)
        return Text(widget.text, style: style);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.text, maxLines: expand ? null : 2, style: style),
          GestureDetector(
            onTap: () => setState(() {
              expand = !expand;
            }),
            child: Text(
              expand ? '<< 收起' : '展开 >>',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
    }),
  );
}
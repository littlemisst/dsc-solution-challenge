import 'package:flutter/material.dart';
import 'package:me_daily/widgets/text_widget.dart';

class ContentBuilder extends StatelessWidget {
  const ContentBuilder({Key key, this.text, this.content}) : super(key:key);
  final String text;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: text)),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(content, style: TextStyle(fontSize: 15.0)))
    ]);
  }
}
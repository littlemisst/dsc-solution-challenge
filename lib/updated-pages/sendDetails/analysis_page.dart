import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class Analysis extends StatelessWidget {
  final text;
  final title;
  final nullMessage;
  final subtitle;
  Analysis({this.text, this.title, this.nullMessage, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(title),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text == null
                    ? Text(nullMessage)
                    : Text(
                        text.toStringAsFixed(2),
                        style: TextStyle(fontSize: 16),
                      ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

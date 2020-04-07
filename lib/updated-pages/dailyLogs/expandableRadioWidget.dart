import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';

class ExpandableRadioCard extends StatefulWidget {
  const ExpandableRadioCard(this.title, this.content, this.groupValue, this.onChanged);
  final String title;
  final List content;
  final String groupValue;
  final ValueChanged<dynamic> onChanged;
  @override
  _ExpandableRadioCardState createState() => _ExpandableRadioCardState();
}

class _ExpandableRadioCardState extends State<ExpandableRadioCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(
            title: Text(widget.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            children: <Widget>[
              Container(
                child: BuildRadioListView(
                  widget.content, widget.groupValue, widget.onChanged),
              )
            ],
          )
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';


class ExpandableRadioCard extends StatefulWidget {
  const ExpandableRadioCard(this.titleIcon, this.title, this.content, this.groupValue, this.onChanged);
  final String title;
  final List content;
  final String groupValue;
  final ImageIcon titleIcon;
  final ValueChanged<dynamic> onChanged;
  @override
  _ExpandableRadioCardState createState() => _ExpandableRadioCardState();
}

class _ExpandableRadioCardState extends State<ExpandableRadioCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: widget.titleIcon,
      title: Text(widget.title),
      children: <Widget>[
        Container(
          child: BuildRadioListView(widget.content, widget.groupValue, widget.onChanged),
        )
      ],
    );
  }
}

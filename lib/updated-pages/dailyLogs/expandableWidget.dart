import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';


class ExpandableCard extends StatefulWidget {
  const ExpandableCard(this.titleIcon, this.title, this.content, this.groupValue, this.onChanged);
  final String title;
  final List content;
  final String groupValue;
  final ImageIcon titleIcon;
  final ValueChanged<dynamic> onChanged;
  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
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

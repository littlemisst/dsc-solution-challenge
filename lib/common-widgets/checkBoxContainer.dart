import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/checkBoxWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class CheckBoxGrid extends StatefulWidget {
  CheckBoxGrid(this.childAspectRatio, this.items, this.itemValues, this.taskAdded);
  final double childAspectRatio;
  final List<String> items;
  final List<bool> itemValues;
  final List<String> taskAdded;

  @override
  _CheckBoxGridState createState() => _CheckBoxGridState();
}


class _CheckBoxGridState extends State<CheckBoxGrid> {
  void _itemChange(List items, List values, bool value, int index) {
    setState(() {
      values[index] = value;
      if (value == true) {
        widget.taskAdded.add(items[index]);
      } else {
        widget.taskAdded.remove(items[index]);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: widget.childAspectRatio) ,
        itemBuilder: (BuildContext context, int index) {
          return LogCheckBox(widget.items[index], widget.itemValues[index], (value) {
            _itemChange(widget.items, widget.itemValues, value, index);
          });
        },
      ))
    );
  }
}


import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxWidget.dart';

class CheckBoxGrid extends StatefulWidget {
  CheckBoxGrid(this.items, this.itemValues, this.taskAdded);
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 6) ,
            itemBuilder: (BuildContext context, int index) {
              return LogCheckBox(widget.items[index], widget.itemValues[index], (value) {
                _itemChange(widget.items, widget.itemValues, value, index);
              });
            },
          ))
      )
    );
  }
}


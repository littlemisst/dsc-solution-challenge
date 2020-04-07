import 'package:flutter/material.dart';

class ItemSummaryBuilder extends StatelessWidget {
  ItemSummaryBuilder(this.task, this.item);
  final String task;
  final int item;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: Text(task, style: TextStyle(fontWeight: FontWeight.bold))),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Icon(Icons.check, color: Colors.green[300]),
                  SizedBox(width: 5),
                  Text('$item', style: TextStyle(fontSize: 13))
                ],),
              );
            }),
        ]),
    );   
  }
}


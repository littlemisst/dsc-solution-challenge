import 'package:flutter/material.dart';

class ListSummaryBuilder extends StatelessWidget {
  ListSummaryBuilder(this.task, this.items);
  final String task;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: Text(task, style: TextStyle(fontWeight: FontWeight.bold))),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Icon(Icons.check, color: Colors.green[300]),
                  SizedBox(width: 5),
                  Text('${items[index]}', style: TextStyle(fontSize: 13))
                ],),
              );
            }),
        ]),
    );   
  }
}


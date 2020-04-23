import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  ListBuilder(this.items);
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Icon(Icons.add, color: Theme.of(context).primaryColor),
                  SizedBox(width: 5),
                  Text('${items[index]}', style: TextStyle(fontSize: 13))
                ],),
              );
            }),
        ]),
    );   
  }
}


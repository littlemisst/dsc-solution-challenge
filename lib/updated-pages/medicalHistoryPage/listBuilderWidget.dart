import 'package:flutter/material.dart';
class ListBuilder extends StatefulWidget {
  ListBuilder({Key key, this.items, this.edit}): super(key:key);
  final List<String> items;
  final bool edit;
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.edit ? 
              Dismissible(
                key: Key(widget.items[index]),
                onDismissed: (direction) {
                setState(() {
                  widget.items.removeAt(index);
                });
                }, 
              child: ListTile(
                title: Row(children: <Widget>[
                  Icon(Icons.add, color: Theme.of(context).primaryColor),
                  SizedBox(width: 5),
                  Text('${widget.items[index]}', style: TextStyle(fontSize: 13)),
                ]),
              )):
              ListTile(
                title: Row(children: <Widget>[
                  Icon(Icons.add, color: Theme.of(context).primaryColor),
                  SizedBox(width: 5),
                  Text('${widget.items[index]}', style: TextStyle(fontSize: 13))
                ]),
              );
            }),
        ]),
    );   
  }
}



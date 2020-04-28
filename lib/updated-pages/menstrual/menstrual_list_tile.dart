
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';

class MenstrualListTileModel {
  const MenstrualListTileModel({
    @required this.periodStarts,
    @required this.periodEnds,
    @required this.flow,
    @required this.cycle});
  final DateTime periodStarts;
  final DateTime periodEnds;
  final String flow;
  final String cycle;
}

class MenstrualListTile extends StatelessWidget {
  const MenstrualListTile({@required this.model});
  final MenstrualListTileModel model;

  @override
  Widget build(BuildContext context) {

    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        leading: Icon(CupertinoIcons.circle_filled,
        color:  model.flow == Strings.normal ? Theme.of(context).primaryColor : Colors.red
        ), 
        title: Column(children: <Widget>[
          Align(child: Text('${model.flow} / ${model.cycle}', style: TextStyle(fontWeight: FontWeight.bold,
          color:  model.flow == Strings.normal ?Theme.of(context).primaryColor : Colors.red)),alignment: Alignment.centerLeft), 
          Align(child: Text('${model.flow}', style: TextStyle(fontWeight: FontWeight.bold, 
          color:  model.flow == Strings.normal ? Theme.of(context).primaryColor : Colors.red,
          )),alignment: Alignment.centerLeft),
        ])
      )
    );
  }
}



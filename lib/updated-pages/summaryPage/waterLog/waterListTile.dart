
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class WaterListTileModel {
  const WaterListTileModel({
    @required this.waterCount,
    @required this.waterML,
    @required this.logCreated});
  final int waterCount;
  final int waterML;
  final DateTime logCreated;
}

class WaterListTile extends StatelessWidget {
  const WaterListTile({@required this.model});
  final WaterListTileModel model;

  @override
  Widget build(BuildContext context) {
    String format = DateFormat.yMMMMd().format(model.logCreated);
    const fontSize = 15.0;
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        leading: Icon(CupertinoIcons.circle_filled,  color: model.waterCount < 8 ? Colors.red : Theme.of(context).primaryColor),
        title: Column(children: <Widget>[ 
          Row(
            children: <Widget>[
              Align(child: Text( model.waterCount <= 1 ? '${model.waterCount} glass' : '${model.waterCount} glasses',
              style: TextStyle(fontSize: fontSize, color: model.waterCount < 8 ? Colors.red : Theme.of(context).primaryColor, 
              fontWeight: FontWeight.bold)),alignment: Alignment.centerLeft),
              Align(child: Text(' | ${model.waterML} mL', style: TextStyle(color: Colors.grey)), 
              alignment: Alignment.centerLeft),
            ],
          ),
          
          Align(child: Text(format, style: TextStyle(fontSize: fontSize)), alignment: Alignment.centerLeft),  
        ])
      )
    );
  }
}



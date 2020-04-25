import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class IncrementCard extends StatelessWidget {
  const IncrementCard({Key key, this.timesText, this.intText, this.onPressedIncrement, this.onPressedDecrement}) : super (key:key);
  final String timesText;
  final int intText;
  final VoidCallback onPressedIncrement;
  final VoidCallback onPressedDecrement;
  
  @override
  Widget build(BuildContext context) {
     return ContentContainer(
       child:
        Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: Align(
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(timesText, style: TextStyle(fontSize: 15)),
                    SizedBox(height: 5),
                    Text('$intText', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)) 
                    ]),
                SizedBox(width: 10),
                Expanded(child: FlatButton(
                  child: ImageIcon(AssetImage("images/minus.png"), color: Theme.of(context).accentColor, size: 40),
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide.none),
                  onPressed: onPressedDecrement)),
                Expanded(child: FlatButton(
                  child: ImageIcon(AssetImage("images/add.png"), color:Theme.of(context).accentColor, size: 40), 
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide.none),
                  onPressed: onPressedIncrement)),
              ])
            )
        ),
     );
  }
}
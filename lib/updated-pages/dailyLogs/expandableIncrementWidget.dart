import 'package:flutter/material.dart';

class ExpandableIncrementCard extends StatelessWidget {
  const ExpandableIncrementCard(this.leadingIcon, this.titleText, this.timesText, this.intText, this.onPressedIncrement, this.onPressedDecrement, this.onPressedSet);
  final ImageProvider leadingIcon;
  final String titleText;
  final String timesText;
  final int intText;
  final VoidCallback onPressedIncrement;
  final VoidCallback onPressedDecrement;
  final VoidCallback onPressedSet;
  @override
  Widget build(BuildContext context) {
     return Container(
      child: Align (
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(leading: ImageIcon(leadingIcon, color: Colors.pink[100]),
          title: Text(titleText),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Text(timesText, style: TextStyle(fontSize: 15)),
              SizedBox(width: 10),
              Text('$intText', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Expanded(
                child: FlatButton(
                  child: ImageIcon(AssetImage("images/add.png"), color: Colors.pink[100]), 
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide.none),
                  onPressed: onPressedIncrement)),
              Expanded(
                child: FlatButton(
                  child: ImageIcon(AssetImage("images/minus.png"), color: Colors.pink[100]),
                  color: Colors.white, 
                  shape: CircleBorder(side: BorderSide.none),
                  onPressed: onPressedDecrement)),
              Expanded(
                child: FlatButton(
                  child: Text('set'),
                  onPressed: onPressedSet))
            ])
          ],
        )
      )
    ));
  }
}
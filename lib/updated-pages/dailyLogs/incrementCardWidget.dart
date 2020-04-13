import 'package:flutter/material.dart';

class IncrementCard extends StatelessWidget {
  const IncrementCard(this.timesText, this.intText, this.onPressedIncrement, this.onPressedDecrement, this.onPressedSet);
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
                      child: ImageIcon(AssetImage("images/minus.png"), color: Colors.pink[100], size: 40),
                      color: Colors.white,
                      shape: CircleBorder(side: BorderSide.none),
                      onPressed: onPressedDecrement)),
                    Expanded(child: FlatButton(
                      child: ImageIcon(AssetImage("images/add.png"), color: Colors.pink[100], size: 40), 
                      color: Colors.white,
                      shape: CircleBorder(side: BorderSide.none),
                      onPressed: onPressedIncrement)),
                    SizedBox(width: 40),
                    Expanded(child: FlatButton(
                      child: Text('set'),
                      onPressed: onPressedSet))
                  ])
                )
            )
        )
      )
    );
  }
}
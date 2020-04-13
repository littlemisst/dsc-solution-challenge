import 'package:flutter/material.dart';

class IconItem extends StatelessWidget {
  const IconItem(
    this.icon,
    this.text,
    this.iconSize,
    this.iconColor,
    this.onPressed
  );
  final AssetImage icon;
  final String text;
  final double iconSize;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var flatButton = FlatButton(
      focusColor: Theme.of(context).accentColor,
      padding: EdgeInsets.all(0),
        child: ImageIcon(
          icon,
          size: iconSize,
          color: iconColor
        ),
        splashColor: Theme.of(context).accentColor,
        shape: CircleBorder(side: BorderSide.none),
        color: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed
      );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        flatButton,
        SizedBox(height: 3),
        Text(text, style: TextStyle(fontSize: 15, color: Colors.grey)),
      ],
    );
  }
}


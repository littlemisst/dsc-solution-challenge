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
        child: ImageIcon(
          icon,
          size: iconSize,
          color: iconColor
        ),
        color: Colors.white,
        shape: CircleBorder(side: BorderSide.none),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed
      );
    return Column(
      children: <Widget>[
        flatButton,
        SizedBox(height: 3),
        Text(text, style: TextStyle(fontSize: 11)),
      ],
    );
  }
}


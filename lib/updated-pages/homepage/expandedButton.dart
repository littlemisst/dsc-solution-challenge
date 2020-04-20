import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton(this.icon, this.text, this.onPressed);
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          children: <Widget>[
            Icon(icon, color: Colors.grey),
            Text(text,
              style: TextStyle(color: Colors.grey, fontSize: 11))
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class FlatButtonIcon extends StatelessWidget {
  const FlatButtonIcon(this.icon, this.label, this.onPressed);
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
       Icon(icon, color: Colors.white),
       Text(label, style: TextStyle(color: Colors.white))
    ]),
    shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor), borderRadius: BorderRadius.circular(20)),
    color: Theme.of(context).primaryColor,
    onPressed: onPressed
  );
  }
}
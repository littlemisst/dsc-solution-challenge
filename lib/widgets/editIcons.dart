import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({Key key, this.text, this.route}) : super(key:key);
  final String text;
  final String route;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text),
      shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor), borderRadius: BorderRadius.circular(45)),
      onPressed: () => Navigator.popAndPushNamed(context, route),
    
    );
  }
}
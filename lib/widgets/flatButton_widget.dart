import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({Key key, this.child, this.color, this.onPressed}) 
  : super(key:key);
  final child;
  final color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      child: child,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor), 
      borderRadius: BorderRadius.circular(10)),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';

class RecordButton extends StatelessWidget {
  const RecordButton(this.onPressed);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        Strings.record,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
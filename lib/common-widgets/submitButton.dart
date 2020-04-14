import 'package:flutter/material.dart';
class SubmitButton extends StatelessWidget {
  const SubmitButton(
    this.text,
    this.onPressed
  );
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Theme.of(context).buttonColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)),
      child: Text(text),
      onPressed: onPressed
    );
  }
}
import 'package:flutter/material.dart';
class SubmitButton extends StatelessWidget {
  const SubmitButton(
    {Key key, this.text,
    this.color,
    this.outlineColor,
    this.textColor,
    this.icon,
    this.onPressed}
  ) : super(key:key);
  final String text;
  final Color color;
  final Color outlineColor;
  final Color textColor;
  final bool icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
      color: color,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), side: BorderSide(color: outlineColor)),
      child: icon ? Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Image(image: AssetImage("images/google.png"), width: 20, height: 20),
        SizedBox(width: 20),
        Text(text)
      ]) :
        Text(text),
      onPressed: onPressed
    ));
  }
}
import 'package:flutter/material.dart';

class FloatingActionToSave extends StatelessWidget {
  const FloatingActionToSave(this.onPressed, this.buttonIcon);
  final VoidCallback onPressed;
  final IconData buttonIcon;


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(buttonIcon, color: Colors.white));
  }
}
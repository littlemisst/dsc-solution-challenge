import 'package:flutter/material.dart';

class ViewHistory extends StatelessWidget {
  const ViewHistory(this.onTap);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text('View History', 
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColor),
        ),
      splashColor: Theme.of(context).primaryColor,
      onTap: onTap,
    );
  }
}
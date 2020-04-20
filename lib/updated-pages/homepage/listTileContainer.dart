import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({Key key, this.top, this.bottom, this.child}) : super(key:key);
  final Widget child;
  final double top;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, top, 20, bottom),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey[200]))),
      child: child
    );
  }
}
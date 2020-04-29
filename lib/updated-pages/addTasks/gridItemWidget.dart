import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/iconItem.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key key, this.child}) : super(key:key);
  final IconItem child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.white,
      child: child
    );
  }
}
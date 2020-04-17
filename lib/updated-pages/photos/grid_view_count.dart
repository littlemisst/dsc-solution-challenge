import 'package:flutter/material.dart';

class GridViewCount extends StatelessWidget {
  GridViewCount({this.children});
  final children;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
        children: children,
      ),
    );
  }
}
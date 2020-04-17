import 'package:flutter/material.dart';

class SliverGridCount extends StatelessWidget {
  SliverGridCount ({this.children});
  final children;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 1,
      children: children
    );
  }
}
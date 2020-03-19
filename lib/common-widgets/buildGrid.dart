import 'package:flutter/material.dart';

class BuildGridItems extends StatelessWidget {
  const BuildGridItems(this.gridItems, this.crossAxisCount, this.aspectRatio);
  final List<Widget> gridItems;
  final int crossAxisCount;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, childAspectRatio: aspectRatio),
      children: gridItems,
    );
  }
}

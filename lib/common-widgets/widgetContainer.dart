import 'package:flutter/material.dart';
class ContentContainer extends StatelessWidget {
  const ContentContainer({Key key, this.padding, this.child, this.width, this.margin}) : super(key:key);
  final EdgeInsets padding;
  final Widget child;
  final double width;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      padding: padding,
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: child
      )
    );
  }
}


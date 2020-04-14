import 'package:flutter/material.dart';
class ContentContainer extends StatelessWidget {
  const ContentContainer({Key key, this.padding, this.child, this.width}) : super(key:key);
  final EdgeInsets padding;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
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


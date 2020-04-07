import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  final String imageURL;
  final String tag;

  FullScreen({this.imageURL, this.tag});
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.tag,
            child: Image.network(
              widget.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

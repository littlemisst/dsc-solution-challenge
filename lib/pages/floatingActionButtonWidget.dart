import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  @override
  _FloatingActionButtonWidgetState createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    super.initState();
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset.fromDirection(0, animation.value * 70),
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.addTaskRoute),
            backgroundColor: Colors.pink[100],
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(4.71239, animation.value * 70),
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, Strings.addPhotoRoute),
            backgroundColor: Colors.pink[100],
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.add_photo_alternate,
              color: Colors.white,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(3.14159, animation.value * 70),
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.addDailyLogRoute),
            backgroundColor: Colors.pink[100],
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.playlist_add_check,
              color: Colors.white,
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          backgroundColor: Colors.pink[100],
          elevation: 10,
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 5)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

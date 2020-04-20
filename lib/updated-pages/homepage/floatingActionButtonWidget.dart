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
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Transform.scale(
          scale: 100 * animation.value,
          child: Opacity(
            opacity: 0.5,
            child: Container(
              width: 15,
              height: 20,
              color: Colors.grey,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(0, animation.value * 70),
          child: FloatingActionButton(
            heroTag: 'addTaskButton',
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.addTaskRoute),
            backgroundColor: Theme.of(context).buttonColor,
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(3.14159, animation.value * 70),
          child: FloatingActionButton(
            heroTag: 'addPhotoButton',
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.addPhotoRoute),
            backgroundColor: Theme.of(context).buttonColor,
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.add_photo_alternate,
              color: Colors.white,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(4.71239, animation.value * 70),
          child: FloatingActionButton(
            heroTag: 'addDailyLogButton',
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.addDailyLogRoute),
            backgroundColor: Theme.of(context).buttonColor,
            elevation: 10,
            mini: true,
            child: Icon(
              Icons.playlist_add_check,
              color: Colors.white,
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: 'mainButton',
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          backgroundColor: Theme.of(context).buttonColor,
          elevation: 10,
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 5)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        Container(
          width: 200,
          height: 310,
        )
      ],
    );
  }
}

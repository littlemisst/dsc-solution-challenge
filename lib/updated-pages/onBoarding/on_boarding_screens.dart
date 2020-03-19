import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';

class OnBoardingScreen extends StatelessWidget {
  final pageList = [
    PageModel(
        color: Colors.pink[100],
        heroAssetPath: 'images/well.png',
        heroAssetColor: Colors.white,
        title: Text('Hello page 1'),
        body: Text('so you have log'),
        iconAssetPath: 'images/unwell.png'),
    PageModel(
        color: Colors.blue[100],
        heroAssetPath: 'images/well.png',
        heroAssetColor: Colors.white,
        title: Text('Hello page 2'),
        body: Text('so you have log'),
        iconAssetPath: 'images/unwell.png'),
    PageModel(
        color: Colors.purple[100],
        heroAssetPath: 'images/well.png',
        heroAssetColor: Colors.white,
        title: Text('Hello page 3'),
        body: Text('so you have log'),
        iconAssetPath: 'images/unwell.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        onDoneButtonPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
        },
        pageList: pageList,
      ),
    );
  }
}

import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/services/shared_preferences_service.dart';

class OnBoardingScreen extends StatelessWidget {
  final pageList = [
    PageModel(
        color: Colors.cyan,
        heroAssetPath: 'images/onBoard1.png',
        heroAssetColor: Colors.white,
        title: Text('WELCOME TO ME DAILY', 
        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        body: ContentContainer(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Text('Insert caption here')),
          ),
        iconAssetPath: 'images/unwell.png',
        ),
        
    PageModel(
        color: Colors.blueGrey[100],
        heroAssetPath: 'images/onBoard2.png',
        heroAssetColor: Colors.white,
        title: Text('Hello page 2'),
        body: Text('so you have log'),
        iconAssetPath: 'images/unwell.png'),
    PageModel(
        color: Colors.purple[100],
        heroAssetPath: 'images/onBoard3.png',
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
          SharedPreferencesService.setIsNewlyInstalled(false);
          Navigator.pushReplacementNamed(context, Strings.authenticationRoute);
        },
        onSkipButtonPressed: () {
          SharedPreferencesService.setIsNewlyInstalled(false);
          Navigator.pushReplacementNamed(context, Strings.authenticationRoute);
        },
        pageList: pageList,
      ),
    );
  }
}

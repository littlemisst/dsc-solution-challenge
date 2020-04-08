import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/services/shared_preferences_service.dart';

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

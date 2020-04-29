import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/services/shared_preferences_service.dart';

class OnBoardingScreen extends StatelessWidget {
  final pageList = [
    PageModel(
        color: Colors.white,
        heroAssetPath: 'images/onBoard1.png',

        title: Text('Track your Health Everyday', 
        style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold)),
        body:Container(),
        iconAssetPath: 'images/well.png',
        ),
        
    PageModel(
        color: Colors.white,
        heroAssetPath: 'images/onBoard2.png',
        title: Text('Create Task, Save Files & Log your Daily Health Status',
        style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold)),
        body: Container(),
        iconAssetPath: 'images/well.png'),
    PageModel(
        color: Colors.white,
        heroAssetPath: 'images/onBoard3.png',
        
        title: Text('Share your Health Status',
        style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold)),
        body: Container(),
        iconAssetPath: 'images/well.png')
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

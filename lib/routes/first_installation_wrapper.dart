import 'package:flutter/material.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/services/shared_preferences_service.dart';
import 'package:me_daily/updated-pages/onBoarding/on_boarding_screens.dart';

class FirstInstallationWrapper extends StatefulWidget {
  @override
  _FirstInstallationWrapperState createState() =>
      _FirstInstallationWrapperState();
}

class _FirstInstallationWrapperState extends State<FirstInstallationWrapper> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen();
  }
}

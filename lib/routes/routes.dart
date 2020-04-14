import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/pages/addPhotos.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/routes/first_installation_wrapper.dart';
import 'package:me_daily/updated-pages/addTasks/addTask.dart';
import 'package:me_daily/updated-pages/authentication/reset_password_page.dart';
import 'package:me_daily/updated-pages/authentication/sign_in_form.dart';
import 'package:me_daily/updated-pages/authentication/verification_page.dart';
import 'package:me_daily/updated-pages/dailyLogs/addDailyLog.dart';
import 'package:me_daily/updated-pages/sendDetails/sendDetailsPage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Strings.initialRoute:
        return MaterialPageRoute(builder: (_) => FirstInstallationWrapper());
      case Strings.authenticationRoute:
        return MaterialPageRoute(builder: (_) => AuthenticationWrapper());
      case Strings.signInRoute:
        return MaterialPageRoute(builder: (_) => SignIn());
      case Strings.verificationRoute:
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case Strings.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      case Strings.sendDetailsRoute:
        return MaterialPageRoute(builder: (_) => SendDetailsPage());
      case Strings.addTaskRoute:
        return MaterialPageRoute(builder: (_) => AddTask());
      case Strings.addPhotoRoute:
        return MaterialPageRoute(builder: (_) => AddPhotos());
      case Strings.addDailyLogRoute:
        return MaterialPageRoute(builder: (_) => AddDailyLogs());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}

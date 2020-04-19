import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/pages/addPhotos.dart';
import 'package:me_daily/pages/helpPage.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/pages/messagePage.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/routes/first_installation_wrapper.dart';
import 'package:me_daily/updated-pages/addTasks/addTask.dart';
import 'package:me_daily/updated-pages/addTasks/addTaskViewItems.dart';
import 'package:me_daily/updated-pages/authentication/reset_password_form.dart';
import 'package:me_daily/updated-pages/authentication/reset_password_page.dart';
import 'package:me_daily/updated-pages/authentication/sign_in_form.dart';
import 'package:me_daily/updated-pages/authentication/verification_page.dart';
import 'package:me_daily/updated-pages/dailyLogs/addDailyLog.dart';
import 'package:me_daily/updated-pages/dailyLogs/basicQuestionsLog.dart';
import 'package:me_daily/updated-pages/dailyLogs/sickQuestionsLog.dart';
import 'package:me_daily/updated-pages/locationLog/location_log_summary.dart';
import 'package:me_daily/updated-pages/profile/edit_profile/edit_profile_page.dart';
import 'package:me_daily/updated-pages/profile/profile_page.dart';
import 'package:me_daily/updated-pages/sendDetails/sendDetailsPage.dart';
import 'package:me_daily/updated-pages/summaryPage/summaryPage.dart';

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
      case Strings.mapPage:
        return MaterialPageRoute(builder: (_) => MapPage());
      case Strings.locationLogSummary:
        return MaterialPageRoute(builder: (_) => LocationLogSummary());
      case Strings.addTaskRoute:
        return MaterialPageRoute(builder: (_) => AddTask());
      case Strings.taskViewItemsRoute:
        var data = routeSettings.arguments as Task;
        return MaterialPageRoute(builder: (_) => TaskViewItems(task: data));
      case Strings.addPhotoRoute:
        return MaterialPageRoute(builder: (_) => AddPhotos());
      case Strings.addDailyLogRoute:
        return MaterialPageRoute(builder: (_) => AddDailyLogs());
      case Strings.basicQuestionsLogRoute:
        var data = routeSettings.arguments as DailyLog;
        return MaterialPageRoute(
            builder: (_) => BasicQuestionsLogPage(entry: data));
      case Strings.sickQuestionsLogRoute:
        var data = routeSettings.arguments as DailyLog;
        return MaterialPageRoute(
            builder: (_) => SickQuestionsLogPage(entry: data));
      case Strings.profilePageRoute:
        return MaterialPageRoute(builder: (_) => MainProfile());
      case Strings.editProfilePageRoute:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case Strings.summaryPageRoute:
        return MaterialPageRoute(builder: (_) => SummaryPage());
      case Strings.resetPasswordFormRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordForm());
        case Strings.messagesPage:
        return MaterialPageRoute(builder: (_) => MessagesPage());
        case Strings.helpPage:
        return MaterialPageRoute(builder: (_) => HelpPage());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}

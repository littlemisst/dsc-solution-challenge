import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/updated-pages/calendarPage/calendarPage.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/services/firestore_service.dart';

class DailyTaskCalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Task>>.value(
      value: FirestoreService(uid: user.uid).allTasksStream,
      child: Container(
        child: CalendarPage(),
      ),
    );
  }
}

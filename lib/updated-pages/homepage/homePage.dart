import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/calendarPage/dailyTasksPage.dart';
import 'package:me_daily/updated-pages/homepage/sideDrawer.dart';
import 'package:me_daily/updated-pages/photos/gallery_page.dart';
import 'package:me_daily/updated-pages/summaryPage/summaryPage.dart';
import 'package:provider/provider.dart';

import 'floatingActionButtonWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final bodies = [
    SummaryPage(),
    GalleryPage(),
    DailyTaskCalendarPage(),
    MapPage(),
  ];

  Widget _sideDrawer() {
    final user = Provider.of<User>(context);
    return StreamProvider<Profile>.value(
        value: FirestoreService(uid: user.uid).profile,
        child: SideDrawerWidget()
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('ME DAILY'),
      ),
      drawer: _sideDrawer(),
      body: bodies[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        shape: CircularNotchedRectangle(),
        elevation: 8,
        color: Colors.white,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () => setState(() {
                    _currentIndex = 0;
                  }),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () => setState(() {
                    _currentIndex = 1;
                  }),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        color: Colors.grey,
                      ),
                      Text(
                        'Files',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () => setState(() {
                    _currentIndex = 2;
                  }),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      Text(
                        'Today',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () => setState(() {
                    _currentIndex = 3;
                  }),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      Text(
                        'Maps',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

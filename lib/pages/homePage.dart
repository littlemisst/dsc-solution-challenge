import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/pages/addPhotos.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/addTasks/addTask.dart';
import 'package:me_daily/updated-pages/calendarPage/dailyTasksPage.dart';
import 'package:me_daily/updated-pages/dailyLogs/addDailyLog.dart';
import 'package:me_daily/updated-pages/photos/gallery_page.dart';
import 'package:me_daily/updated-pages/profile/profile_page.dart';
import 'package:me_daily/updated-pages/sendDetails/sendDetailsPage.dart';
import 'package:me_daily/updated-pages/summaryPage/summaryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuthentication();

  int _currentIndex = 0;

  void handleClick(String value) {
    switch (value) {
      case 'Sign Out':
        _firebaseAuth.signOut();
        break;
      case 'Send Details':
        Navigator.push(context, MaterialPageRoute(builder: (context) => SendDetailsPage()));
        break;
    }
}

  final bodies = [
    SummaryPage(),
    GalleryPage(),
    DailyTaskCalendarPage(),
    MapPage(),
    MainProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('ME DAILY', Colors.black),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Theme.of(context).accentColor),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Sign Out', 'Send Details'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: bodies[_currentIndex],
      floatingActionButton: _currentIndex != 3 && _currentIndex != 4
          ? SpeedDial(
              child: Icon(Icons.add, color: Colors.white),
              overlayColor: Colors.white,
              overlayOpacity: 0.6,
              children: [
                  SpeedDialChild(
                      child: Icon(Icons.add_box,  color: Colors.white),
                      label: 'Add Task',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddTask()));
                      }),
                  SpeedDialChild(
                      child:
                          Icon(Icons.add_photo_alternate,  color: Colors.white),
                      label: 'Add Image',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPhotos()));
                      }),
                  SpeedDialChild(
                      child:
                          Icon(Icons.playlist_add_check,  color: Colors.white),
                      label: 'Add Daily Log',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDailyLogs()));
                      }),
                ])
          : null,
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _currentIndex,
          selectedFontSize: 10.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Theme.of(context).backgroundColor
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file),
              title: Text('Files'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Calendar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text('Profile'),
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}

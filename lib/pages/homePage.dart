import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:me_daily/main.dart';
import 'package:me_daily/pages/addDailyLog.dart';
import 'package:me_daily/pages/addPhoto.dart';
import 'package:me_daily/pages/addTask.dart';
import 'package:me_daily/pages/calendarPage.dart';
import 'package:me_daily/pages/filesPage.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/pages/profile_page.dart';
import 'package:me_daily/pages/summaryPage.dart';
// import 'package:me_daily/pages/viewTasksPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final bodies = [
    SummaryPage(),
    MapPage(),
    Files(),
    CalendarPage(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me Daily', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
      body: bodies[_currentIndex],
       floatingActionButton: _currentIndex != 4 ? SpeedDial(
          backgroundColor: Colors.pink[100],
          child: Icon(Icons.add),
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add_box),
                label: 'Add Task',
                backgroundColor: Colors.pink[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTask()));
                }),
            SpeedDialChild(
                child: Icon(Icons.add_photo_alternate),
                label: 'Add Image',
                backgroundColor: Colors.pink[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPhoto()));
                }),
            SpeedDialChild(
                child: Icon(Icons.playlist_add_check),
                label: 'Add Daily Log',
                backgroundColor: Colors.pink[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddDailyLogs()));
                }),
          ]) : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 10.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.pink[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
              backgroundColor: Colors.pink[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file),
              title: Text('Files'),
              backgroundColor: Colors.pink[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              backgroundColor: Colors.pink[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text('Profile'),
              backgroundColor: Colors.pink[100],
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

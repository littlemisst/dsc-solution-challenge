import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/pages/addPhotos.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/pages/popUpMenu.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/addTasks/addTask.dart';
import 'package:me_daily/updated-pages/calendarPage/calendarPage.dart';
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

  final bodies = [
    SummaryPage(),
    GalleryPage(),
    DailyTaskCalendarPage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me Daily', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            child: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainProfile())),
          ),
          PopUpMenu()
        ],
      ),
      body: bodies[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: SpeedDial(
      //   curve: Curves.easeIn,
      //     child: Icon(Icons.add, color: Colors.white),
      //     overlayColor: Colors.black,
      //     overlayOpacity: 0.6,
      //     children: [
      //       SpeedDialChild(
      //           child: Icon(Icons.add_box, color: Colors.white),
      //           label: 'Add Task',
      //           onTap: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => AddTask()));
      //           }),
      //       SpeedDialChild(
      //           child: Icon(Icons.add_photo_alternate, color: Colors.white),
      //           label: 'Add Image',
      //           onTap: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => AddPhotos()));
      //           }),
      //       SpeedDialChild(
      //           child: Icon(Icons.playlist_add_check, color: Colors.white),
      //           label: 'Add Daily Log',
      //           onTap: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => AddDailyLogs()));
      //           }),
      //     ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.popAndPushNamed(context, Strings.sendDetailsRoute),
        backgroundColor: Colors.pink[100],
        elevation: 10,
        //mini: true,
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 5)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 5,
        color: Colors.white,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[Icon(Icons.home)],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     selectedFontSize: 10.0,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         title: Text('Home'),
      //         backgroundColor: Colors.pink[100],
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.insert_drive_file),
      //         title: Text('Files'),
      //         backgroundColor: Colors.pink[100],
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.calendar_today),
      //         title: Text('Calendar'),
      //         backgroundColor: Colors.pink[100],
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.location_on),
      //         title: Text('Map'),
      //         backgroundColor: Colors.pink[100],
      //       ),
      //     ],
      //     onTap: (index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:me_daily/pages/floatingActionButtonWidget.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/pages/popUpMenu.dart';
import 'package:me_daily/updated-pages/calendarPage/dailyTasksPage.dart';
import 'package:me_daily/updated-pages/photos/gallery_page.dart';
import 'package:me_daily/updated-pages/profile/profile_page.dart';
import 'package:me_daily/updated-pages/summaryPage/summaryPage.dart';

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
      floatingActionButton: FloatingActionButtonWidget(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 8,
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

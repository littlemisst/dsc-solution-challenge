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

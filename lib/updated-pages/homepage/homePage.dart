import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/pages/mapPage.dart';
import 'package:me_daily/updated-pages/calendarPage/dailyTasksPage.dart';
import 'package:me_daily/updated-pages/homepage/expandedButton.dart';
import 'package:me_daily/updated-pages/homepage/sideDrawer.dart';
import 'package:me_daily/updated-pages/onBoarding/on_boarding_screens.dart';
import 'package:me_daily/updated-pages/photos/gallery_page.dart';
import 'package:me_daily/updated-pages/summaryPage/summaryPage.dart';



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('ME DAILY'),
      ),
      drawer: SideDrawerWidget(),
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
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ExpandedButton(Icons.home, 'Home', () => setState(() => _currentIndex = 0)),
              ExpandedButton(Icons.insert_drive_file, 'Files', () => setState(() => _currentIndex = 1)),
              Expanded(flex: 1, child: SizedBox()),
              ExpandedButton(Icons.event, 'Events', () => setState(() => _currentIndex = 2)),
              ExpandedButton(Icons.map, 'Maps', () => setState(() => _currentIndex = 3)),
            ],
          ),
        ),
      ),
    );
  }
}

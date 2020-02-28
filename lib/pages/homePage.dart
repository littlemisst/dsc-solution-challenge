import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:me_daily/pages/addPhoto.dart';
import 'package:me_daily/pages/addTask.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // final bodies = [
      //
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me Daily', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
      // body: bodies[_currentIndex],
      floatingActionButton: SpeedDial(
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
              MaterialPageRoute(
                builder: (context) =>TaskInput())
              );
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.add_photo_alternate),
            label: 'Add Image',
            backgroundColor: Colors.pink[100],
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => AddPhoto())
              );
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.playlist_add_check),
            label: 'Add Daily Log',
            backgroundColor: Colors.pink[100],
          ),
        ]
      ),
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
        }
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Daily Logs', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
    );
  }
}

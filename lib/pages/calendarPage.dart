import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    var _currentDate;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.pink[100],
        ),
        weekFormat: false,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,
      ),
    );
  }
}

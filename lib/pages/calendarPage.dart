import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    var _currentDate;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              calendarStyle: CalendarStyle(
                  todayColor: Colors.pink[100],
                  selectedColor: Colors.grey,
                  outsideDaysVisible: false,
                  weekendStyle: TextStyle().copyWith(color: Colors.pink),
                  holidayStyle: TextStyle().copyWith(color: Colors.pink)),
              initialCalendarFormat: CalendarFormat.month,
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              headerStyle: HeaderStyle(
                  centerHeaderTitle: true, formatButtonVisible: false),
              builders: CalendarBuilders(
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 1,
                        child: _buildEventsMarker(date, events),
                      ),
                    );
                  }
                },
              ),
              onDaySelected: (date, events) {},
              calendarController: _calendarController,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.pink[200]
            : _calendarController.isToday(date)
                ? Colors.pink[100]
                : Colors.grey,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}

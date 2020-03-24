import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/calendarPage.dart/dailyTasks.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  Map<DateTime,List<dynamic>> _tasks;
  List<dynamic> _selectedTasks;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    final _selectedDay = DateTime.now();
    _tasks = {};
    _selectedTasks = _tasks[_selectedDay] ?? [];
  }

  Future<Map<DateTime, List>> tasksMap(context) async {
    _tasks = await getTasksListOnSpecificDate(context);
    return _tasks;
  }

  @override
  Widget build(BuildContext context) {
    tasksMap(context);
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildCalendar(),
            Expanded(child: _buildEventList(_selectedTasks)),
          ],
        ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List tasks) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date) ? Colors.pink[100] 
             : _calendarController.isToday(date)? Colors.pink[100] : Colors.grey,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${tasks.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
  Widget _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _tasks,
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
          return children; 
        }, 
      ),
      onDaySelected: (date, tasks) {
        setState(() {
          _selectedTasks = tasks;
        });
      },
    );
  }
  Widget _buildEventList(events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(events[index].toString()),
          ),
        );
      }
    );
  }
}

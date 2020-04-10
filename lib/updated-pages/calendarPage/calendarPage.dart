import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/updated-pages/calendarPage/dailyTasksDetails.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _tasks;
  List<dynamic> _selectedTasks;
  

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    final _selectedDay = DateTime.now();
    _tasks = {};
    _selectedTasks = _tasks[_selectedDay] ?? [];
  }


  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    if (tasks == null) {
      tasks = [];
    }
    _tasks = DailyTaskDetails.tasksByDate(tasks);
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 15),
            _buildCalendar(),
            SizedBox(height: 15),
            Expanded(child: _buildEventList(_selectedTasks, context)),
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
    return Container(
      child: Material(
        color: Colors.white,
        elevation: 1,
        child:
          TableCalendar(
            calendarController: _calendarController,
            events: _tasks,
            calendarStyle: CalendarStyle(
                todayColor: Colors.pink[100],
                selectedColor: Colors.grey,
                outsideDaysVisible: false,
                weekendStyle: TextStyle().copyWith(color: Colors.pink)),
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
          )
      )
    );
  }
  
  Widget _buildEventList(events, context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Material(
              color: Colors.white,
              elevation: 1,
              child: ListTile(
              title: Row(children: <Widget>[
                Icon(Icons.check_box_outline_blank, color: Colors.pink[100]),
                SizedBox(width: 5),
                Text(events[index].toString(), style: TextStyle(fontSize: 15))
              ])
            )
          )
        );
      }
    );

  }
}


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
            SizedBox(height: 10),
            _buildCalendar(),
            SizedBox(height: 10),
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
      padding: EdgeInsets.all(10),
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child:
          TableCalendar(
            calendarController: _calendarController,
            events: _tasks,
            calendarStyle: CalendarStyle(
                todayColor: Colors.grey,
                selectedColor: Colors.pink[100],
                outsideDaysVisible: false,
                weekendStyle: TextStyle().copyWith(color: Colors.pink[300])),
            initialCalendarFormat: CalendarFormat.month,
            formatAnimation: FormatAnimation.slide,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            availableGestures: AvailableGestures.all,
            headerStyle: HeaderStyle(
              leftChevronIcon: Icon(Icons.navigate_before, color: Colors.pink[100]),
              rightChevronIcon: Icon(Icons.navigate_next, color: Colors.pink[100]),
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.pink[100]),
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
    return
    events.length == 0 ?
    Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Align(
          alignment: Alignment.center,
          child:Text('No tasks available'))
      )
    )
    :
    ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
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


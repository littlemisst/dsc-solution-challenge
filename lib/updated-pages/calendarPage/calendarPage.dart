import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
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
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 10),
          _buildCalendar(),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: 
            Align(
            alignment: Alignment.centerLeft,
            child: Text('EVENTS', 
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: Colors.grey))
            ),
          ),
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
        color: _calendarController.isSelected(date) ? Theme.of(context).primaryColor
             : _calendarController.isToday(date)?Theme.of(context).primaryColor : Colors.grey,
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
    return ContentContainer(
      padding: EdgeInsets.all(10),
      child: 
      TableCalendar(
        calendarController: _calendarController,
        events: _tasks,
        calendarStyle: CalendarStyle(
            todayColor: Colors.grey,
            selectedColor: Theme.of(context).primaryColor,
            outsideDaysVisible: false,
            weekendStyle: TextStyle().copyWith(color: Theme.of(context).buttonColor)),
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).buttonColor),
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
    );
  }
  
  Widget _buildEventList(events, context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    if (tasks == null) {
      tasks = [];
    }
    _tasks = DailyTaskDetails.tasksByDate(tasks);
    return
    events.length == 0 ?
    ContentContainer(
      width: MediaQuery.of(context).size.width,
      padding:EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Align(
          alignment: Alignment.center,
          child:Text('No tasks available'))
    )
    :
    ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return ContentContainer(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: ListTile(
              title: Row(children: <Widget>[
                Icon(Icons.indeterminate_check_box, color: Theme.of(context).primaryColor),
                SizedBox(width: 5),
                Text(events[index].toString(), style: TextStyle(fontSize: 15))
              ])
            )
          );
      }
    );

  }
}


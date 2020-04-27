import 'package:me_daily/model/task.dart';

class DailyTaskDetails {
  static Map<DateTime, List<dynamic>> tasksByDate(List<Task> tasks) {
    Map<DateTime, List<Task>> map = {};
    
    for (var task in tasks) {
      final taskDayStart = task.taskStarted;
      if (map[taskDayStart] == null) {
        map[taskDayStart] = [task];
      } else {
        map[taskDayStart].add(task);
      }
    }
    return map;
  }
}
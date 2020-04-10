import 'package:me_daily/model/task.dart';

class DailyTaskDetails {
  static Map<DateTime, List<dynamic>> tasksByDate(List<Task> tasks) {
    Map<DateTime, List<String>> map = {};
    
    for (var task in tasks) {
      String specificTask = '${task.taskType} - ${task.specificTask}';
      final taskDayStart = task.taskStarted;
      if (map[taskDayStart] == null) {
        map[taskDayStart] = [specificTask];
      } else {
        map[taskDayStart].add(specificTask);
      }
    }
    print(map);
    return map;
  }
}
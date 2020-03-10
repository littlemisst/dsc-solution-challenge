class Task {
  String taskType;
  DateTime dateCreated = DateTime.now();
  String specificTask;
  DateTime taskStarted;
  DateTime taskEnded;
  DateTime time;
  bool completed = false;

  Task();

  Map<String, dynamic> toJson() => {
    "taskType": taskType,
    "specificTask": specificTask,
    "dateCreated": dateCreated,
    "taskStarted": taskStarted,
    "taskEnded": taskEnded,
    "time": time,
    "completed": completed
  };
}

class Task {
  String taskType;
  DateTime dateCreated;
  String specificTask;
  DateTime taskStarted;
  DateTime taskEnded;
  DateTime time;

  Task(this.taskType, this.dateCreated, this.specificTask, this.taskStarted,
      this.taskEnded, this.time);

  Map<String, dynamic> toJson() => {
        "taskType": taskType,
        "dateCreated": dateCreated,
        "specificTask": specificTask,
        "taskStarted": taskStarted,
        "taskEnded": taskEnded,
        "time": time
      };
}

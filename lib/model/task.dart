class Task {
  String taskType;
  DateTime dateCreated;
  String specificTask;
  DateTime taskStarted;
  DateTime taskEnded;

  Task(this.taskType, this.dateCreated, this.specificTask, this.taskStarted,
      this.taskEnded);

  Map<String, dynamic> toJson() => {
        "taskType": taskType,
        "dateCreated": dateCreated,
        "specificTask": specificTask,
        "taskStarted": taskStarted,
        "taskEnded": taskEnded
      };
}

class Task {
  String taskType;
  DateTime dateCreated;
  String specificTask;

  Task(
    this.taskType,
    this.dateCreated,
    this.specificTask
  );

  Map<String, dynamic> toJson() => {
    "taskType": taskType,
    "dateCreated": dateCreated,
    "specificTask": specificTask
  };
}
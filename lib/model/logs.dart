class Logs {
  
  String emotion;
  String note;
  String taskType;
  String specificTask;
  DateTime taskDone = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Logs();

  Map<String, dynamic> toJson() => {
    "emotion": emotion,
    "note": note,
    "taskType": taskType,
    "specificTask": specificTask,
    "taskDone" : taskDone
  };
}

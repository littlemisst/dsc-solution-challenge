class TaskDifference {
  TaskDifference(this.taskStarted, this.taskEnded);
  final DateTime taskStarted;
  final DateTime taskEnded;

  int get days {
    Duration difference = taskEnded.difference(taskStarted);
    return difference.inDays;
  }
}


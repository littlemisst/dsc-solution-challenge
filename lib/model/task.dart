import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';
@JsonSerializable(nullable: false)
class Task {
  DateTime taskCreated = DateTime.now();
  String taskType;
  String specificTask;
  DateTime taskStarted;
  DateTime taskEnded;
  DateTime taskTime;
  bool completed = false;

  Task({this.taskType});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() =>  _$TaskToJson(this);
}

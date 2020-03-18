import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';
@JsonSerializable(nullable: false)
class Task {
  @JsonKey(name: 'taskCreated')
  DateTime taskCreated = DateTime.now();

  @JsonKey(name: 'taskType')
  String taskType;

  @JsonKey(name: 'specificTask')
  String specificTask;

  @JsonKey(name: 'taskStarted')
  DateTime taskStarted;

  @JsonKey(name: 'taskEnded')
  DateTime taskEnded;

  @JsonKey(name: 'taskTime')
  DateTime taskTime;

  @JsonKey(name: 'completed')
  bool completed = false;

  Task({this.taskType, this.specificTask, this.taskStarted, this.taskEnded, this.taskTime});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() =>  _$TaskToJson(this);
}

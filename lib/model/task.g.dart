// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    taskType: json['taskType'] as String,
    specificTask: json['specificTask'] as String,
    taskStarted: DateTime.parse(json['taskStarted'] as String),
    taskEnded: DateTime.parse(json['taskEnded'] as String),
    taskTime: json['taskTime'] as String,
  )
    ..taskCreated = DateTime.parse(json['taskCreated'] as String)
    ..completed = json['completed'] as bool;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskCreated': instance.taskCreated.toIso8601String(),
      'taskType': instance.taskType,
      'specificTask': instance.specificTask,
      'taskStarted': instance.taskStarted.toIso8601String(),
      'taskEnded': instance.taskEnded.toIso8601String(),
      'taskTime': instance.taskTime,
      'completed': instance.completed,
    };

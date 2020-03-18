// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    taskType: json['taskType'] as String,
    specificTask: json['specificTask'] as String,
    taskStarted: json['taskStarted'] as DateTime,
    taskEnded: json['taskEnded'] as DateTime,
    taskTime: json['taskTime'] as DateTime,
  )
    ..taskCreated = json['taskCreated'] as DateTime
    ..completed = json['completed'] as bool;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskCreated': instance.taskCreated,
      'taskType': instance.taskType,
      'specificTask': instance.specificTask,
      'taskStarted': instance.taskStarted,
      'taskEnded': instance.taskEnded,
      'taskTime': instance.taskTime,
      'completed': instance.completed,
    };

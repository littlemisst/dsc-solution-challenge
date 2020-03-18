// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyLog _$DailyLogFromJson(Map<String, dynamic> json) {
  return DailyLog(
    feeling: json['feeling'] as String,
    food: json['food'] as String,
    drink: json['drink'] as String,
    exercise: json['exercise'] as String,
    hoursSlept: json['hoursSlept'] as int,
  )..logCreated = DateTime.parse(json['logCreated'] as String);
}

Map<String, dynamic> _$DailyLogToJson(DailyLog instance) => <String, dynamic>{
      'logCreated': instance.logCreated.toIso8601String(),
      'feeling': instance.feeling,
      'food': instance.food,
      'drink': instance.drink,
      'exercise': instance.exercise,
      'hoursSlept': instance.hoursSlept,
    };

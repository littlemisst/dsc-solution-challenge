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
    waterDrank: json['waterDrank'] as int,
  )..logCreated = DateTime.parse(json['logCreated'] as String);
}

Map<String, dynamic> _$DailyLogToJson(DailyLog instance) => <String, dynamic>{
      'logCreated': instance.logCreated,
      'feeling': instance.feeling,
      'food': instance.food,
      'drink': instance.drink,
      'exercise': instance.exercise,
      'hoursSlept': instance.hoursSlept,
      'waterDrank': instance.waterDrank,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyLog _$DailyLogFromJson(Map<String, dynamic> json) {
  return DailyLog(
    feeling: json['feeling'] as String,
  )
    ..logCreated = json['logCreated'] == null
        ? null
        : DateTime.parse(json['logCreated'] as String)
    ..food = (json['food'] as List)?.map((e) => e as String)?.toList()
    ..drink = (json['drink'] as List)?.map((e) => e as String)?.toList()
    ..exercise = (json['exercise'] as List)?.map((e) => e as String)?.toList()
    ..hoursSlept = json['hoursSlept'] as int
    ..waterDrank = json['waterDrank'] as int
    ..symptoms = (json['symptoms'] as List)?.map((e) => e as String)?.toList()
    ..temperature = (json['temperature'] as num)?.toDouble()
    ..symptomsStarted = json['symptomsStarted'] == null
        ? null
        : DateTime.parse(json['symptomsStarted'] as String)
    ..timeOfOccurance = json['timeOfOccurance'] == null
        ? null
        : DateTime.parse(json['timeOfOccurance'] as String);
}

Map<String, dynamic> _$DailyLogToJson(DailyLog instance) => <String, dynamic>{
      'logCreated': instance.logCreated?.toIso8601String(),
      'feeling': instance.feeling,
      'food': instance.food,
      'drink': instance.drink,
      'exercise': instance.exercise,
      'hoursSlept': instance.hoursSlept,
      'waterDrank': instance.waterDrank,
      'symptoms': instance.symptoms,
      'temperature': instance.temperature,
      'symptomsStarted': instance.symptomsStarted?.toIso8601String(),
      'timeOfOccurance': instance.timeOfOccurance?.toIso8601String(),
    };

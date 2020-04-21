// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) {
  return Temperature(
    type: json['type'] as String,
    temperature: (json['temperature'] as num)?.toDouble(),
    logCreated: json['logCreated'] == null
        ? null
        : DateTime.parse(json['logCreated'] as String),
  );
}

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'temperature': instance.temperature,
      'logCreated': instance.logCreated?.toIso8601String(),
    };

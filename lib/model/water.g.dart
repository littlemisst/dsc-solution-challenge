// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Water _$WaterFromJson(Map<String, dynamic> json) {
  return Water(
    type: json['type'] as String,
    waterDrank: json['waterDrank'] as int,
    waterInML: json['waterInML'] as int,
    logCreated: json['logCreated'] == null
        ? null
        : DateTime.parse(json['logCreated'] as String),
  );
}

Map<String, dynamic> _$WaterToJson(Water instance) => <String, dynamic>{
      'type': instance.type,
      'waterDrank': instance.waterDrank,
      'waterInML': instance.waterInML,
      'logCreated': instance.logCreated?.toIso8601String(),
    };

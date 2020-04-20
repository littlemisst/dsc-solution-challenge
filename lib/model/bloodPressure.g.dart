// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloodPressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) {
  return BloodPressure(
    systolic: json['systolic'] as int,
    diastolic: json['diastolic'] as int,
    logCreated: json['logCreated'] == null
        ? null
        : DateTime.parse(json['logCreated'] as String),
  );
}

Map<String, dynamic> _$BloodPressureToJson(BloodPressure instance) =>
    <String, dynamic>{
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'logCreated': instance.logCreated?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloodPressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) {
  return BloodPressure(
    type: json['type'] as String,
    systolic: json['systolic'] as int,
    diastolic: json['diastolic'] as int,
    diagnosis: json['diagnosis'] as String,
    logCreated: json['logCreated'] == null
        ? null
        : DateTime.parse(json['logCreated'] as String),
  );
}

Map<String, dynamic> _$BloodPressureToJson(BloodPressure instance) =>
    <String, dynamic>{
      'type': instance.type,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'diagnosis': instance.diagnosis,
      'logCreated': instance.logCreated?.toIso8601String(),
    };

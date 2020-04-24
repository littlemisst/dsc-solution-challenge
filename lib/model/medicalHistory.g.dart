// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicalHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistory _$MedicalHistoryFromJson(Map<String, dynamic> json) {
  return MedicalHistory(
    hospitalized: json['hospitalized'] as bool,
    foodAllergy:
        (json['foodAllergy'] as List)?.map((e) => e as String)?.toList(),
    drugAllergy:
        (json['drugAllergy'] as List)?.map((e) => e as String)?.toList(),
    chronicDisease:
        (json['chronicDisease'] as List)?.map((e) => e as String)?.toList(),
    immunizations:
        (json['immunizations'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MedicalHistoryToJson(MedicalHistory instance) =>
    <String, dynamic>{
      'hospitalized': instance.hospitalized,
      'foodAllergy': instance.foodAllergy,
      'drugAllergy': instance.drugAllergy,
      'chronicDisease': instance.chronicDisease,
      'immunizations': instance.immunizations,
    };

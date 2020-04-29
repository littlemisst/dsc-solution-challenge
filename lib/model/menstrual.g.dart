// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menstrual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menstrual _$MenstrualFromJson(Map<String, dynamic> json) {
  return Menstrual(
    periodStarts: json['periodStarts'] == null
        ? null
        : DateTime.parse(json['periodStarts'] as String),
    periodEnds: json['periodEnds'] == null
        ? null
        : DateTime.parse(json['periodEnds'] as String),
    flow: json['flow'] as String,
    cycle: json['cycle'] as String,
  );
}

Map<String, dynamic> _$MenstrualToJson(Menstrual instance) => <String, dynamic>{
      'periodStarts': instance.periodStarts?.toIso8601String(),
      'periodEnds': instance.periodEnds?.toIso8601String(),
      'flow': instance.flow,
      'cycle': instance.cycle,
    };

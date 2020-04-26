// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return UserSummary(
    profile: json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    averageHoursSlept: (json['averageHoursSlept'] as num)?.toDouble(),
    averageWaterDrank: (json['averageWaterDrank'] as num)?.toDouble(),
    previousLocations: (json['previousLocations'] as List)
        ?.map((e) =>
            e == null ? null : LocationLog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    activities: (json['activities'] as List)?.map((e) => e as String)?.toList(),
    bloodPressureHistory: (json['bloodPressureHistory'] as List)
        ?.map((e) => e == null
            ? null
            : BloodPressure.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    temperatureHistory: (json['temperatureHistory'] as List)
        ?.map((e) =>
            e == null ? null : Temperature.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    recipient: json['recipient'] == null
        ? null
        : User.fromJson(json['recipient'] as Map<String, dynamic>),
    sender: json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>),
    dateSent: json['dateSent'] == null
        ? null
        : DateTime.parse(json['dateSent'] as String),
  );
}

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      'profile': instance.profile?.toJson(),
      'averageHoursSlept': instance.averageHoursSlept,
      'averageWaterDrank': instance.averageWaterDrank,
      'previousLocations':
          instance.previousLocations?.map((e) => e?.toJson())?.toList(),
      'activities': instance.activities,
      'bloodPressureHistory':
          instance.bloodPressureHistory?.map((e) => e?.toJson())?.toList(),
      'temperatureHistory':
          instance.temperatureHistory?.map((e) => e?.toJson())?.toList(),
      'recipient': instance.recipient?.toJson(),
      'sender': instance.sender?.toJson(),
      'dateSent': instance.dateSent?.toIso8601String(),
    };

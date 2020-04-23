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
    previousLocations: (json['previousLocations'] as List)
        ?.map((e) =>
            e == null ? null : LocationLog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    activities: (json['activities'] as List)?.map((e) => e as String)?.toList(),
    recipient: json['recipient'] == null
        ? null
        : User.fromJson(json['recipient'] as Map<String, dynamic>),
    sender: json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      'profile': instance.profile?.toJson(),
      'averageHoursSlept': instance.averageHoursSlept,
      'previousLocations':
          instance.previousLocations?.map((e) => e?.toJson())?.toList(),
      'activities': instance.activities,
      'recipient': instance.recipient?.toJson(),
      'sender': instance.sender?.toJson(),
    };

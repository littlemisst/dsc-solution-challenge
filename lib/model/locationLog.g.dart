// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationLog _$LocationLogFromJson(Map<String, dynamic> json) {
  return LocationLog(
    locationName: json['locationName'] as String,
    dateAndTime: json['dateAndTime'] == null
        ? null
        : DateTime.parse(json['dateAndTime'] as String),
  );
}

Map<String, dynamic> _$LocationLogToJson(LocationLog instance) =>
    <String, dynamic>{
      'locationName': instance.locationName,
      'dateAndTime': instance.dateAndTime?.toIso8601String(),
    };
import 'package:json_annotation/json_annotation.dart';

part 'locationLog.g.dart';

@JsonSerializable()
class LocationLog {
  String locationName;
  DateTime dateAndTime;

  LocationLog({this.locationName, this.dateAndTime});

  factory LocationLog.fromJson(Map<String, dynamic> json) =>
      _$LocationLogFromJson(json);
  Map<String, dynamic> toJson() => _$LocationLogToJson(this);
}

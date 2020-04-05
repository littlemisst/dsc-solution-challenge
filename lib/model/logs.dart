import 'package:json_annotation/json_annotation.dart';

part 'logs.g.dart';
@JsonSerializable(nullable: true)
class DailyLog {
  DateTime logCreated = DateTime.now();
  String feeling;
  String food;
  String drink;
  String exercise;
  int hoursSlept;
  int waterDrank;
  Map<String, bool> symptoms;
  double temperature;
  DateTime symptomsStarted = DateTime.now();
  DateTime timeOfOccurance;

  DailyLog({this.feeling});

  factory DailyLog.fromJson(Map<String, dynamic> json) => _$DailyLogFromJson(json);
  Map<String, dynamic> toJson() =>  _$DailyLogToJson(this);
}

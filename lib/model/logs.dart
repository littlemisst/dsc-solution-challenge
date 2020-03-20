import 'package:json_annotation/json_annotation.dart';

part 'logs.g.dart';
@JsonSerializable(nullable: true)
class DailyLog {
  @JsonKey(name: 'logCreated')
  DateTime logCreated = DateTime.now();

  @JsonKey(name: 'feeling')
  String feeling;

  @JsonKey(name: 'food')
  String food;

  @JsonKey(name: 'drink')
  String drink;

  @JsonKey(name: 'exercise')
  String exercise;

  @JsonKey(name: 'hoursSlept')
  int hoursSlept;

  @JsonKey(name: 'waterDrank')
  int waterDrank;

  @JsonKey(name: 'symptoms')
  Map<String, bool> symptoms;

  @JsonKey(name: 'symptomsStarted')
  DateTime symptomsStarted;

  @JsonKey(name: 'timeOfOccurance')
  DateTime timeOfOccurance;

  DailyLog({this.feeling});

  factory DailyLog.fromJson(Map<String, dynamic> json) => _$DailyLogFromJson(json);
  Map<String, dynamic> toJson() =>  _$DailyLogToJson(this);
}

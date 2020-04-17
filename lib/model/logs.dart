import 'package:json_annotation/json_annotation.dart';

part 'logs.g.dart';

@JsonSerializable(nullable: true)
class DailyLog {
  DateTime logCreated = DateTime.now();
  String feeling;
  List<String> food;
  List<String> drink;
  List<String> exercise;
  int hoursSlept;
  int waterDrank;
  List<String> symptoms;
  double temperature;
  DateTime symptomsStarted = DateTime.now();
  DateTime timeOfOccurance;

  DailyLog({
    this.feeling,
    this.food,
    this.drink,
    this.exercise,
    this.hoursSlept,
    this.symptoms,
    this.timeOfOccurance
  });

  factory DailyLog.fromJson(Map<String, dynamic> json) =>
      _$DailyLogFromJson(json);
  Map<String, dynamic> toJson() => _$DailyLogToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'logs.g.dart';
@JsonSerializable(nullable: false)
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




  DailyLog({this.feeling, this.food, this.drink, this.exercise, this.hoursSlept});

  factory DailyLog.fromJson(Map<String, dynamic> json) => _$DailyLogFromJson(json);
  Map<String, dynamic> toJson() =>  _$DailyLogToJson(this);
}

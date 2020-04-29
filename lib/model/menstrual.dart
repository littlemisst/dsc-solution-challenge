import 'package:json_annotation/json_annotation.dart';

part 'menstrual.g.dart';

@JsonSerializable()
class Menstrual {
  final DateTime periodStarts;
  final DateTime periodEnds;
  final String flow;
  final String cycle;

  Menstrual({this.periodStarts, this.periodEnds, this.flow, this.cycle});
  factory Menstrual.fromJson(Map<String, dynamic> json) =>
      _$MenstrualFromJson(json);
  Map<String, dynamic> toJson() => _$MenstrualToJson(this);
}

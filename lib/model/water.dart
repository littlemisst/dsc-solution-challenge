import 'package:json_annotation/json_annotation.dart';

part 'water.g.dart';

@JsonSerializable()
class Water {
  final String type;
  final int waterDrank;
  final int waterInML;
  final DateTime logCreated;

  Water({this.type, this.waterDrank, this.waterInML, this.logCreated});

  factory Water.fromJson(Map<String, dynamic> json) => _$WaterFromJson(json);
  Map<String, dynamic> toJson() => _$WaterToJson(this);
}

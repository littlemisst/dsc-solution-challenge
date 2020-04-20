import 'package:json_annotation/json_annotation.dart';

part 'water.g.dart';

@JsonSerializable()
class Water {
  final int waterDrank;
  final DateTime logCreated;

 Water({this.waterDrank, this.logCreated});

   factory Water.fromJson(Map<String, dynamic> json) =>
      _$WaterFromJson(json);
  Map<String, dynamic> toJson() => _$WaterToJson(this);
}

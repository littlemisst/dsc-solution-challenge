import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

@JsonSerializable()
class Temperature {
  final double temperature;
  final DateTime logCreated;

 Temperature({this.temperature, this.logCreated});

   factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

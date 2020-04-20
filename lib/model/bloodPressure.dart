import 'package:json_annotation/json_annotation.dart';

part 'bloodPressure.g.dart';

@JsonSerializable()
class BloodPressure {
  final int systolic;
  final int diastolic;
  final DateTime logCreated;

 BloodPressure({this.systolic, this.diastolic, this.logCreated});

   factory BloodPressure.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureToJson(this);
}

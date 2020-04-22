import 'package:json_annotation/json_annotation.dart';

part 'bloodPressure.g.dart';

@JsonSerializable()
class BloodPressure {
  final String type;
  final int systolic;
  final int diastolic;
  final String diagnosis;
  final DateTime logCreated;

  BloodPressure(
      {this.type,
      this.systolic,
      this.diastolic,
      this.diagnosis,
      this.logCreated});

  factory BloodPressure.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureToJson(this);
}

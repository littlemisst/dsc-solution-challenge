import 'package:json_annotation/json_annotation.dart';

part 'medicalHistory.g.dart';

@JsonSerializable(nullable: true)
class MedicalHistory {
  bool hospitalized;
  List<String> foodAllergy;
  List<String> drugAllergy;
  List<String> chronicDisease;
  List<String> immunizations;
  MedicalHistory({this.hospitalized, this.foodAllergy, this.drugAllergy, this.chronicDisease, this.immunizations});

  factory MedicalHistory.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalHistoryToJson(this);
}

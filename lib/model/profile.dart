import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  String name;
  String address;
  String civilStatus;
  String gender;
  DateTime birthDate;
  String bloodType;
  double height;
  double weight;
  String profilePhotoFileName;
  String downloadUrl;

  Profile({
    this.name,
    this.address,
    this.birthDate,
    this.gender,
    this.civilStatus,
    this.bloodType,
    this.height,
    this.weight,
    this.downloadUrl,
    this.profilePhotoFileName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

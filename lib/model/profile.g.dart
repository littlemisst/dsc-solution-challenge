// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    name: json['name'] as String,
    address: json['address'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    gender: json['gender'] as String,
    civilStatus: json['civilStatus'] as String,
    bloodType: json['bloodType'] as String,
    height: (json['height'] as num)?.toDouble(),
    weight: (json['weight'] as num)?.toDouble(),
    downloadUrl: json['downloadUrl'] as String,
    profilePhotoFileName: json['profilePhotoFileName'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'civilStatus': instance.civilStatus,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'bloodType': instance.bloodType,
      'height': instance.height,
      'weight': instance.weight,
      'profilePhotoFileName': instance.profilePhotoFileName,
      'downloadUrl': instance.downloadUrl,
    };

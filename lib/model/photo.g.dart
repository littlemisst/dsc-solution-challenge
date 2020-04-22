// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    fileName: json['fileName'] as String,
    downloadURL: json['downloadURL'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'downloadURL': instance.downloadURL,
      'description': instance.description,
    };

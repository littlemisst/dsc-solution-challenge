import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';
@JsonSerializable()
class Photo {
  String fileName;
  String downloadURL;
  String description;

  Photo({this.fileName, this.downloadURL, this.description});

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

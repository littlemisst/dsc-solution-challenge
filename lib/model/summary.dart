import 'package:json_annotation/json_annotation.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';

import 'locationLog.dart';

part 'summary.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSummary {
  Profile profile;
  double averageHoursSlept;
  List<LocationLog> previousLocations;
  List<String> activities;
  User recipient;
  User sender;

  UserSummary(
      {this.profile,
      this.averageHoursSlept,
      this.previousLocations,
      this.activities,
      this.recipient,
      this.sender});

  // factory UserSummary.fromJson(Map<String, dynamic> json) =>
  //     _$UserSummaryFromJson(json);
  //auto generated not functioning

  Map<String, dynamic> toJson() => _$UserSummaryToJson(this);

  factory UserSummary.fromJson(Map<String, dynamic> json) => UserSummary(
      activities: List<String>.from(json['activities']),
      profile: json['profile'] == null
          ? null
          : Profile(
              name: json['profile']['name'],
              address: json['profile']['address'],
              birthDate: DateTime.parse(json['profile']['birthDate']),
              gender: json['profile']['gender'],
              civilStatus: json['profile']['civilStatus'],
              bloodType: json['profile']['bloodType'],
              height: (json['profile']['height']).toDouble(),
              weight: (json['profile']['weight']).toDouble(),
              downloadUrl: json['profile']['downloadUrl'].toString(),
              profilePhotoFileName: json['profile']['profilePhotoFileName']),
      sender: User(email: json['sender']['email'], uid: json['sender']['uid']),
      recipient: User(
          email: json['recipient']['email'], uid: json['recipient']['uid']),
      averageHoursSlept: json['averageHoursSlept'],
      previousLocations: (json['previousLocations'] as List).isEmpty
          ? []
          : (json['previousLocations'] as List)
              .map((prevLocation) => LocationLog(
                  locationName: prevLocation['locationName'],
                  dateAndTime: DateTime.parse(prevLocation['dateAndTime'])))
              .toList());
}

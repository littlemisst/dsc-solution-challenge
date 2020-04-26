import 'package:json_annotation/json_annotation.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/model/user.dart';

import 'locationLog.dart';

part 'summary.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSummary {
  Profile profile;
  double averageHoursSlept;
  double averageWaterDrank;
  List<LocationLog> previousLocations;
  List<String> activities;
  List<BloodPressure> bloodPressureHistory;
  List<Temperature> temperatureHistory;
  User recipient;
  User sender;
  DateTime dateSent;

  UserSummary(
      {this.profile,
      this.averageHoursSlept,
      this.averageWaterDrank,
      this.previousLocations,
      this.activities,
      this.bloodPressureHistory,
      this.temperatureHistory,
      this.recipient,
      this.sender,
      this.dateSent});

  // factory UserSummary.fromJson(Map<String, dynamic> json) =>
  //     _$UserSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$UserSummaryToJson(this);

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
        dateSent: DateTime.parse(json['dateSent']),
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
        sender:
            User(email: json['sender']['email'], uid: json['sender']['uid']),
        recipient: User(
            email: json['recipient']['email'], uid: json['recipient']['uid']),
        averageHoursSlept: json['averageHoursSlept'],
        averageWaterDrank: json['averageWaterDrank'],
        previousLocations: (json['previousLocations'] as List).isEmpty
            ? []
            : (json['previousLocations'] as List).map((prevLocation) =>
                LocationLog(
                    locationName: prevLocation['locationName'],
                    dateAndTime: DateTime.parse(prevLocation['dateAndTime']))),
        temperatureHistory: (json['temperatureHistory'] as List).isEmpty
            ? []
            : (json['temperatureHistory'] as List)
                .map((temp) => Temperature(
                    type: temp['type'],
                    temperature: temp['temperature'],
                    logCreated: DateTime.parse(temp['logCreated'])))
                .toList());
  }
}

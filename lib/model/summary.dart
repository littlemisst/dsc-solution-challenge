import 'package:json_annotation/json_annotation.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';

part 'summary.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSummary {
  Profile profile;
  double averageHoursSlept;
  User recipient;
  User sender;
  List<LocationLog> previousLocations;
  List<String> activities;

  UserSummary(
      {this.profile,
      this.averageHoursSlept,
      this.previousLocations,
      this.activities,
      this.recipient,
      this.sender});

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$UserSummaryToJson(this);
}

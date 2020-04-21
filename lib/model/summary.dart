import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';

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
  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "averageHoursSlept": averageHoursSlept,
        "previousLocations":
            previousLocations.map((location) => location.toJson()).toList(),
        "activities": activities.toList(),
        "recipient": recipient.toJson(),
        "sender": sender.toJson()
      };
}

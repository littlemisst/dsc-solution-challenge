import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';

class UserSummary {
  Profile profile;
  double averageHoursSlept;
  User recipient;
  User sender;

  UserSummary(
      {this.profile, this.averageHoursSlept, this.recipient, this.sender});
  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "averageHoursSlept": averageHoursSlept,
        "recipient": recipient.toJson(),
        "sender": sender.toJson()
      };
}

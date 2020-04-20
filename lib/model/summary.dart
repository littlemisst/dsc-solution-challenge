import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';

class UserSummary {
  Profile profile;
  DailyLog dailyLog;
  User recipient;
  User sender;

  UserSummary({this.profile, this.dailyLog, this.recipient});
  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "dailyLog": dailyLog,
        "recipient": recipient.toJson(),
        "sender" : sender.toJson()
      };
}

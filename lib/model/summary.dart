import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/profile.dart';

class UserSummary {
  Profile profile;
  DailyLog dailyLog;
  String recipient;

  UserSummary({this.profile, this.dailyLog, this.recipient});
  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "dailyLog": dailyLog,
        "recipient": recipient,
      };
}

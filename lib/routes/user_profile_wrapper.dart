import 'package:flutter/material.dart';
import 'package:me_daily/pages/user_profile_summary.dart';
import 'package:me_daily/pages/update_profile.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/profile.dart';

class UserProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return profile == null ? UpdateProfile() : UserProfileSummary();
  }
}

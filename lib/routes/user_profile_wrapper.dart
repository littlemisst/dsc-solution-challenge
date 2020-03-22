import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/updated-pages/profile/update_profile.dart';
import 'package:me_daily/updated-pages/profile/user_profile_summary.dart';

class UserProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return profile == null ? UpdateProfile() : UserProfileSummary();
  }
}

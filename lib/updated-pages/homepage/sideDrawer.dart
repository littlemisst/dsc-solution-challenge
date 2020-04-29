import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/homepage/ItemList.dart';
import 'package:me_daily/updated-pages/homepage/listTileContainer.dart';
import 'package:provider/provider.dart';

class SideDrawerWidget extends StatefulWidget {
  @override
  _SideDrawerWidgetState createState() => _SideDrawerWidgetState();
}

class _SideDrawerWidgetState extends State<SideDrawerWidget> {
  final firebaseAuth = FirebaseAuthentication();

  Widget _userProfile(profilePic, email, initial) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
        child: Row(children: <Widget>[
          profilePic == null
              ? CircleAvatar(
                  child: Text(initial, style: TextStyle(color: Colors.white)),
                  radius: 25,
                  backgroundColor: Theme.of(context).primaryColor)
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(profilePic, scale: 30)),
          Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormat('ME DAILY'),
                      Text(email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey))
                    ])),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    Profile _currentProfile = Provider.of<Profile>(context);
    User _user = Provider.of<User>(context);

    return Drawer(
        child: Column(children: <Widget>[
      ItemContainer(
        top: 20,
        bottom: 20,
        child: _currentProfile != null
            ? _userProfile(_currentProfile.downloadUrl, _user.email,
                _currentProfile.name.substring(0, 1).toUpperCase())
            : _userProfile(
                null, _user.email, _user.email.substring(0, 1).toUpperCase()),
      ),
      Expanded(
          child: ItemContainer(
              top: 0,
              bottom: 0,
              child: Column(children: <Widget>[
                ListItem(
                  icon: Icons.person,
                  text: Strings.profile,
                  onTap: () async => Navigator.popAndPushNamed(
                      context, Strings.profilePageRoute),
                ),
                ListItem(
                  icon: Icons.message,
                  text: Strings.message,
                  onTap: () async =>
                      Navigator.popAndPushNamed(context, Strings.messagesPage),
                ),
                ListItem(
                  icon: Icons.share,
                  text: Strings.shareDetails,
                  onTap: () async => Navigator.popAndPushNamed(
                      context, Strings.sendDetailsRoute),
                ),
              ]))),
      ItemContainer(
          top: 0,
          bottom: 0,
          child: ListItem(
              icon: Icons.power_settings_new,
              text: Strings.signOut,
              onTap: () async {
                String providerId = await firebaseAuth.getProviderId();
                if (providerId == 'google.com') {
                  await firebaseAuth.googleSignOut();
                }
                return firebaseAuth.signOut();
              })),
    ]));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/sendDetails/sendDetailsPage.dart';

class PopUpMenu extends StatefulWidget {
  @override
  _PopUpMenuState createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  _onSelect(action) {
    switch (action) {
      case Strings.sendDetailsRoute:
        Navigator.popAndPushNamed(context, Strings.sendDetailsRoute);
        break;
      case 'Sign Out':
        FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: _onSelect,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: Strings.sendDetailsRoute,
              child: Row(
                children: <Widget>[
                  Icon(Icons.share),
                  Text('Share Details'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'Sign Out',
              child: Text('Sign Out'),
            )
          ];
        });
  }
}

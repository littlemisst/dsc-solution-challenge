import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';

class SubmitEdit extends StatefulWidget {
  @override
  _SubmitEditState createState() => _SubmitEditState();
}

class _SubmitEditState extends State<SubmitEdit> {
  Profile _profile = Profile();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Container( child:
      RaisedButtonIcon(Icons.save, 'Submit Edited Profile', () async { _firestoreService.submitProfile(_profile);})
    );
  }
}
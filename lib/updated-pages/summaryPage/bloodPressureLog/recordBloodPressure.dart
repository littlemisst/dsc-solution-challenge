import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/expandedNumberTextFieldWidget.dart';
import 'package:me_daily/common-widgets/recordLogWidget.dart';
import 'package:me_daily/common-widgets/viewHistory.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/bloodPressureLog/checkBp.dart';
import 'package:provider/provider.dart';

class RecordBloodPressure extends StatefulWidget {
  @override
  _RecordBloodPressureState createState() => _RecordBloodPressureState();
}

class _RecordBloodPressureState extends State<RecordBloodPressure> {
  int _systolic;
  int _diastolic;

  
  BloodPressure _bpFromState() {
    String _diagnosis = CheckBloodPressure(_systolic, _diastolic).diagnosis;
    return BloodPressure(type: 'bloodPressure', systolic: _systolic, diastolic: _diastolic, diagnosis: _diagnosis, logCreated: DateTime.now());
  }

  Future<void> _addBPLog(BuildContext context) async {
    String documentID = DateTime.now().toIso8601String();
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final entry = _bpFromState();
    await _firestoreService.addBloodPressureLog(entry, documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                'Blood Pressure',
              ),
            ),
          ),
          ViewHistory(() => Navigator.pushNamed(context, Strings.bpHistoryPage))
        ]),
          Expanded(
            child: Row(
              children: <Widget>[
                ExpandedNumberTextField(Strings.systolic, (value) => _systolic = int.parse(value)),
                SizedBox(width: 5),
                ExpandedNumberTextField(Strings.diastolic, (value) => _diastolic = int.parse(value)),
                RecordButton(() => _addBPLog(context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

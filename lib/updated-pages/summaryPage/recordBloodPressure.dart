import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/expandedTextFieldWidget.dart';
import 'package:me_daily/common-widgets/recordLogWidget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class RecordBloodPressure extends StatefulWidget {
  @override
  _RecordBloodPressureState createState() => _RecordBloodPressureState();
}

class _RecordBloodPressureState extends State<RecordBloodPressure> {
  int _systolic;
  int _diastolic;

  BloodPressure _bpFromState() {
    return BloodPressure(systolic: _systolic, diastolic: _diastolic, logCreated: DateTime.now());
  }

  Future<void> _addBPLog(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final entry = _bpFromState();
    await _firestoreService.addBloodPressureLog(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
         Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                'Blood Pressure',
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                ExpandedTextField(Strings.systolic, (value) => _systolic = int.parse(value)),
                SizedBox(width: 5),
                ExpandedTextField(Strings.diastolic, (value) => _diastolic = int.parse(value)),
                RecordButton(() => _addBPLog(context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

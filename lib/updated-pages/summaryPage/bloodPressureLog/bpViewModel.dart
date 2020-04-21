import 'package:flutter/material.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/bloodPressureLog/bpListTile.dart';


class BloodPressureViewModel {
  BloodPressureViewModel({@required this.database});
  final FirestoreService database;

  Stream<List<BloodPressure>> get _allBloodPressureLog => database.bloodPressure;

  Stream<List<BloodPressureListTileModel>> get bloodPressureTileModelStream => _allBloodPressureLog.map(_createModels);

  static List<BloodPressureListTileModel> _createModels(List<BloodPressure> bloodPressure) {
    if (bloodPressure.isEmpty) {
      return [];
    }
    return  <BloodPressureListTileModel>[
      for (BloodPressure bpLog in bloodPressure) ...[
        BloodPressureListTileModel(systolic: bpLog.systolic, diastolic: bpLog.diastolic, diagnosis: bpLog.diagnosis, logCreated: bpLog.logCreated)
      ]
      
    ];
  }
}
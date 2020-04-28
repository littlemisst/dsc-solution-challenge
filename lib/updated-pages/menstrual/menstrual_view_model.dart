import 'package:flutter/material.dart';
import 'package:me_daily/model/menstrual.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/menstrual/menstrual_list_tile.dart';


class MenstrualViewModel {
  MenstrualViewModel({@required this.database});
  final FirestoreService database;

  Stream<List<Menstrual>> get _allMenstrualLog => database.periodSummary;

  Stream<List<MenstrualListTileModel>> get menstrualTileModelStream => _allMenstrualLog.map(_createModels);

  static List<MenstrualListTileModel> _createModels(List<Menstrual> menstrual) {
    if (menstrual.isEmpty) {
      return [];
    }
    return  <MenstrualListTileModel>[
      for (Menstrual mens in menstrual) ...[
       MenstrualListTileModel(periodEnds: mens.periodEnds, periodStarts: mens.periodStarts, flow: mens.flow, cycle: mens.cycle)
      ]
    ];
  }
}
import 'package:flutter/material.dart';
import 'package:me_daily/model/water.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/waterLog/waterListTile.dart';

class WaterViewModel {
  WaterViewModel({@required this.database});
  final FirestoreService database;

  Stream<List<Water>> get _allWaterLog => database.water;

  Stream<List<WaterListTileModel>> get waterTileModelStream => _allWaterLog.map(_createModels);

  static List<WaterListTileModel> _createModels(List<Water> water) {
    if (water.isEmpty) {
      return [];
    }
    return  <WaterListTileModel>[
      for (Water waterLog in water) ...[
        WaterListTileModel(waterCount: waterLog.waterDrank, waterML: waterLog.waterInML, logCreated: waterLog.logCreated)
      ]
      
    ];
  }
}
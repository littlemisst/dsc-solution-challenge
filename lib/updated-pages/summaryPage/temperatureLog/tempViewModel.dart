import 'package:flutter/material.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/temperatureLog/tempListTile.dart';


class TemperatureViewModel {
  TemperatureViewModel({@required this.database});
  final FirestoreService database;

  Stream<List<Temperature>> get _allTemperatureLog => database.temperature;

  Stream<List<TemperatureListTileModel>> get temperatureTileModelStream => _allTemperatureLog.map(_createModels);

  static List<TemperatureListTileModel> _createModels(List<Temperature> temperature) {
    if (temperature.isEmpty) {
      return [];
    }
    return  <TemperatureListTileModel>[
      for (Temperature temp in temperature) ...[
       TemperatureListTileModel(temperature: temp.temperature, logCreated: temp.logCreated)
      ]
    ];
  }
}
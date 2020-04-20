import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/rawMaterialButton.dart';
import 'package:me_daily/common-widgets/recordLogWidget.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/water.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class RecordWater extends StatefulWidget {
  @override
  _RecordWaterState createState() => _RecordWaterState();
}



class _RecordWaterState extends State<RecordWater> {
  String documentID = DateTime.now().toIso8601String();
  Water _water;

  int _waterCount = 0;

  Water _waterCountFromState() {
    return Water(waterDrank: _waterCount, logCreated: DateTime.now());
  }

  Future<void> _addWaterLog(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final entry = _waterCountFromState();
    await _firestoreService.addWaterLog(entry, documentID);
  }

  Future<void> _updateWaterLog(BuildContext context, int increment) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    await _firestoreService.updateWater(documentID, increment);
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
                'Water',
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButtonWidget(Icons.remove, () {
                  setState(() { 
                     _waterCount--;
                   });
                    if (_waterCount != 0) {
                      _updateWaterLog(context, -1);
                    }
                }),	
                Expanded(
                  child: Center(
                    child: Text(
                      "$_waterCount",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                 RawMaterialButtonWidget(Icons.add, () {
                   setState(() { 
                     _waterCount++;
                   });
                   _water = Water(waterDrank: _waterCount);
                    _water.waterDrank > 1 ?
                     _updateWaterLog(context, 1) : _addWaterLog(context);
                })

              ],
            ),
          ),
        ],
      ),
    );
  }
}

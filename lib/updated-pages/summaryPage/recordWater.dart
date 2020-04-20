import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/rawMaterialButton.dart';
import 'package:me_daily/common-widgets/recordLogWidget.dart';

class RecordWater extends StatefulWidget {
  @override
  _RecordWaterState createState() => _RecordWaterState();
}

int water = 0;

class _RecordWaterState extends State<RecordWater> {
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
                    if (water != 0) {
                      water--;
                    }
                  });
                }),	
                Expanded(
                  child: Center(
                    child: Text(
                      "$water",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                RawMaterialButtonWidget(Icons.add, (){ setState(() => water++);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

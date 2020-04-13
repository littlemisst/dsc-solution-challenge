import 'package:flutter/material.dart';

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
                Expanded(
                  child: RawMaterialButton(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (water != 0) {
                          water--;
                        }
                      });
                    },
                    shape: CircleBorder(),
                    fillColor: Theme.of(context).buttonColor,
                  ),
                ),
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
                Expanded(
                  child: RawMaterialButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        water++;
                      });
                    },
                    shape: CircleBorder(),
                    fillColor: Theme.of(context).buttonColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

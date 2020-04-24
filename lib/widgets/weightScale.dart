import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:me_daily/widgets/indicatorText.dart';

class WeightScale extends StatelessWidget {
  const WeightScale({Key key, this.textController, this.scrollController, this.scaleChanged}) : super(key:key);
  final TextEditingController textController;
  final ScrollController scrollController;
  final ValueChanged<int> scaleChanged;


  Widget _buildWeightField() {
    return Container(
      height: 50.0,
      width: 100,
      child: TextField(
        controller: textController,
        style: TextStyle(fontSize: 15),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Weight', suffixText: 'kg',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        IndicatorText('WEIGHT'),
        HorizontalScale(
          maxValue: 500,
          scaleController: scrollController,
          onChanged: scaleChanged,
          textStyle: TextStyle(
              fontSize: 15, color: Colors.cyan, fontWeight: FontWeight.bold),
          scaleColor: Colors.white10,
          lineColor:Colors.cyan,
        ),
        SizedBox(height: 10),
        Align(alignment: Alignment.centerLeft, child: _buildWeightField())
      ]),
    );
  }
}
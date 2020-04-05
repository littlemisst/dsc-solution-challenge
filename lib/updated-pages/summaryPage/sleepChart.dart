import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:me_daily/model/sleep.dart';

class SleepChart extends StatefulWidget {
  @override
  _SleepChartState createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  @override
  Widget build(BuildContext context) {
    //mockdata
    List<Sleep> sleepList = [
      new Sleep(
          dateTime: DateTime.parse("2020-04-01T14:54:57.436690"), hoursSleep: 8),
      new Sleep(
          dateTime: DateTime.parse("2020-04-02T14:54:57.436690"), hoursSleep: 7),
      new Sleep(
          dateTime: DateTime.parse("2020-04-03T14:54:57.436690"), hoursSleep: 10),
      new Sleep(
          dateTime: DateTime.parse("2020-04-04T14:54:57.436690"), hoursSleep: 5),
      new Sleep(
          dateTime: DateTime.parse("2020-04-05T14:54:57.436690"), hoursSleep: 2)
    ];

    List<charts.Series<Sleep, DateTime>> _createData() {
      return [
        new charts.Series(
            id: 'Sleep',
            data: sleepList,
            domainFn: (Sleep sleep, _) => sleep.dateTime,
            measureFn: (Sleep sleep, _) => sleep.hoursSleep)
      ];
    }

    return charts.TimeSeriesChart(
      _createData(),
      animate: true,
      behaviors: [
        new charts.ChartTitle('Hours of Sleep',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            innerPadding: 18),
      ],
    );
  }
}

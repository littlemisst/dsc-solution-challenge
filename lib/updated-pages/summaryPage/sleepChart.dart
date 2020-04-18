import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:me_daily/model/sleep.dart';
import 'package:provider/provider.dart';

class SleepChart extends StatefulWidget {
  @override
  _SleepChartState createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  @override
  Widget build(BuildContext context) {
    List<Sleep> sleepList = Provider.of<List<Sleep>>(context);
    if (sleepList == null) {
      sleepList = [];
    }

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

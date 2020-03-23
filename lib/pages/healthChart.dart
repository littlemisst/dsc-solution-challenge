import 'package:flutter/material.dart';
import 'package:me_daily/model/feeling.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HealthChart extends StatefulWidget {
  @override
  _HealthChartState createState() => _HealthChartState();
}

class _HealthChartState extends State<HealthChart> {
  @override
  Widget build(BuildContext context) {
    List<Health> feelingsList = Provider.of<List<Health>>(context);
    if (feelingsList == null) {
      feelingsList = [];
    }


    List<charts.Series<Health, dynamic>> _createData() {
      return [
        new charts.Series<Health, dynamic>(
          id: 'Health',
          domainFn: (Health health, _) => health.feeling,
          measureFn: (Health health, _) => health.count,
          data: feelingsList,
        )
      ];
    }

    return charts.PieChart(_createData(),
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 60, arcRendererDecorators: [charts.ArcLabelDecorator()]));
  //   return Text(feelingsList[1].count.toString() +
  //       feelingsList[1].feeling.toString() +
  //       feelingsList.length.toString());
   }
}

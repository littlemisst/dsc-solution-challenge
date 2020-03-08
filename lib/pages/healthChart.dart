import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:me_daily/model/feeling.dart';

class HealthChart extends StatefulWidget {
  @override
  _HealthChartState createState() => _HealthChartState();
}

class _HealthChartState extends State<HealthChart> {
  List<charts.Series<Health, String>> _healthData;

  _generateData() {
    final data = [
      Health('Very Good', 1),
      Health('Good', 5),
      Health('Nuetral', 5),
      Health('Bad', 10),
      Health('Very Bad', 5),
    ];
    _healthData.add(charts.Series(
      id: 'Health',
      domainFn: (Health health, _) => health.feeling,
      measureFn: (Health health, _) => health.count,
      data: data,
      labelAccessorFn: (Health row, _) => '${row.feeling}: ${row.count}',
    ));
  }

  @override
  void initState() {
    _healthData = List<charts.Series<Health, String>>();
    _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(_healthData,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 60, arcRendererDecorators: [charts.ArcLabelDecorator()]));
  }
}

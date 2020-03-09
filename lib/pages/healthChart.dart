import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:me_daily/model/feeling.dart';

class HealthChart extends StatefulWidget {
  @override
  _HealthChartState createState() => _HealthChartState();
}

class _HealthChartState extends State<HealthChart> {
  List<charts.Series<Health, String>> _healthData;

  List<Health> myData;

  _generateData(myData) {
    _healthData.add(charts.Series(
      id: 'Health',
      domainFn: (Health health, _) => health.feeling.toString(),
      measureFn: (Health health, _) => health.count,
      data: myData,
      labelAccessorFn: (Health row, _) => '${row.feeling}: ${row.count}',
    ));
  }

  @override
  void initState() {
    _healthData = List<charts.Series<Health, String>>();
    super.initState();
  }
  Widget _buildChart(context, health) {
    myData = health;
    _generateData(myData);
    return charts.PieChart(_healthData,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 60, arcRendererDecorators: [charts.ArcLabelDecorator()]));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('mockdata').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading ...');
        } else {
          List<Health> health = snapshot.data.documents
              .map((documentSnapshot) => Health.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, health);
        }
      },
    );
  }
}

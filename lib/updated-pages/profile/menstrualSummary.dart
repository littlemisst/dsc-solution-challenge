import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/model/menstrual.dart';
import 'package:me_daily/widgets/medicalHistorySummaryBuilder.dart';

class PeriodSummary extends StatelessWidget {
  const PeriodSummary({Key key, this.period}) : super(key: key);
  final Menstrual period;

  Widget _buildPeriodStarts() {
    String formatStart = DateFormat.yMMMMEEEEd().format(period.periodStarts);
    return ContentBuilder(text: 'Period Start', content: '${formatStart}');
  }

  Widget _buildDaysLeft() {
    var difference = period.periodEnds.difference(DateTime.now()).inDays;
    return Text(
        difference == 1 ? '${difference} day left' : '${difference} days left',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey[400]));
  }

  Widget _buildPeriodEnds() {
    String formatEnd = DateFormat.yMMMMEEEEd().format(period.periodEnds);
    return ContentBuilder(text: 'Period Ends', content: '${formatEnd}');
  }

  Widget _buildExpectedNextPeriod() {
    DateTime next1 = period.periodEnds.add(Duration(days: 28));
    DateTime next2 = period.periodEnds.add(Duration(days: 35));
    String formatNext1 = DateFormat.yMMMMEEEEd().format(next1);
    String formatNext2 = DateFormat.yMMMMEEEEd().format(next2);
    return ContentBuilder(
        text: 'Expected Next Period',
        content: '${formatNext1} - ${formatNext2}');
  }

  Widget _buildFlow() {
    return ContentBuilder(text: 'Flow', content: '${period.flow}');
  }

  Widget _buildCycle() {
    return ContentBuilder(text: 'Cycle', content: '${period.cycle}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 5),
      _buildDaysLeft(),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          Expanded(child: _buildPeriodStarts()),
          Expanded(child: _buildPeriodEnds()),
        ],
      ),
      Divider(),
      Row(
        children: <Widget>[
          Expanded(child: _buildFlow()),
          Expanded(child: _buildCycle()),
        ],
      ),
      Divider(),
      Row(children: <Widget>[Expanded(child: _buildExpectedNextPeriod())]),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/model/menstrual.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/dateRangePickerPeriod.dart';
import 'package:me_daily/widgets/dropDownWidget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';

class MenstrualForm extends StatefulWidget {
  @override
  _MenstrualFormState createState() => _MenstrualFormState();
}

class _MenstrualFormState extends State<MenstrualForm> {
  DateTime _periodStarts;
  DateTime _periodEnds;
  String _flow;
  String _cycle;
  String _initialFlowValue;
  String _initialCycleValue;

  Menstrual _menstrualFromState() {
    return Menstrual(
      periodStarts: _periodStarts,
      periodEnds: _periodEnds,
      flow: _flow,
      cycle: _cycle
    );
  }

   Future<void> _addPeriodLog(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final period = _menstrualFromState();
    await _firestoreService.saveMenstrualPeriodLog(period);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('Update Period Log'),
      ),
      body: SingleChildScrollView(
        child:  Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child : Column(
              children: <Widget>[
                DateRangePickerPeriodWidget(
                elevation: 1,
                taskStarted: _periodStarts,
                taskEnded: _periodEnds,
                setTaskStarted: (date) => setState(() => _periodStarts = date), 
                setTaskEnded: (date) => setState(() => _periodEnds = date)),
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Expanded(
                    child: DropDownWidget(label: 'Flow', items: Strings.flowList,
                      onChanged: (value) {
                        setState(() {
                          _initialFlowValue = value; 
                          _flow = value;
                          }  
                        );
                      },
                      initialValue:  _initialFlowValue
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropDownWidget(label: 'Cycle', items: Strings.cycleList,
                      onChanged: (value) {
                        setState(() {
                          _initialCycleValue = value; 
                          _cycle = value;
                          }  
                        );
                      },
                      initialValue:  _initialCycleValue
                    ),
                  )
                ]),
              ],
            )
          )
        )
      ),
      floatingActionButton:   
      (_periodEnds != null && _periodStarts  != null && _flow != null && _cycle != null) 
      ? FloatingActionToSave(() async {
          _addPeriodLog(context);
          Navigator.popAndPushNamed(context, Strings.profilePageRoute);
        },
        Icons.save_alt) : null,
    );
  }
}


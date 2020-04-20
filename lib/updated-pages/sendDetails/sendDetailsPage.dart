import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/sendDetails/attachmentPage.dart';
import 'package:me_daily/updated-pages/sendDetails/basicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/dailyLogsList.dart';
import 'package:me_daily/updated-pages/sendDetails/recipientSelector.dart';

class SendDetailsPage extends StatefulWidget {
  @override
  _SendDetailsPageState createState() => _SendDetailsPageState();
}

class _SendDetailsPageState extends State<SendDetailsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  static UserSummary userSummary = UserSummary();
  int _currentStep = 0;

  List<Step> get _steps => [
        Step(
          isActive: _currentStep >= 0,
          title: Text('Basic Information'),
          content: BasicInformationPage(
            profile: userSummary.profile,
            onChangeProfile: onChangeProfile,
          ),
        ),
        Step(
          isActive: _currentStep >= 1,
          title: Text('Daily Logs'),
          content: DailyLogsList(),
        ),
        Step(
          isActive: _currentStep >= 2,
          title: Text('Attach Files'),
          content: AttachementPage(),
        ),
        Step(
            isActive: _currentStep >= 3,
            title: Text('Add Receipient'),
            content: RecipientSelector(
                recipient: userSummary.recipient,
                onChangeRecipient: onChangeRecipient))
      ];
  void onChangeRecipient(value) {
    setState(() {
      userSummary.recipient = value;
    });
  }

  void onChangeProfile(value) {
    setState(() {
      userSummary.profile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.initialRoute),
        ),
        title: Text(
          'Submit Details',
          style: TextStyle(color: Colors.pink[100]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stepper(
        currentStep: _currentStep,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[
              FlatButton(
                  child: _currentStep != _steps.length - 1
                      ? Text('Continue', style: TextStyle(color: Colors.white))
                      : Text('Send', style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: _currentStep != _steps.length - 1
                      ? onStepContinue
                      : () async {
                          await _firestoreService.sendSummary(userSummary);
                          Navigator.popAndPushNamed(
                              context, Strings.initialRoute);
                        }),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                child: Text('Back'),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: onStepCancel,
              )
            ],
          );
        },
        onStepContinue: () {
          if (_currentStep >= _steps.length - 1) return;
          setState(() {
            _currentStep++;
          });
        },
        onStepCancel: () {
          if (_currentStep <= 0) return;
          setState(() {
            _currentStep--;
          });
        },
        steps: _steps,
      ),
    );
  }
}

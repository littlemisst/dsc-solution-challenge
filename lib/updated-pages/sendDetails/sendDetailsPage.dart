import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/sendDetails/attachmentPage.dart';
import 'package:me_daily/updated-pages/sendDetails/basicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/dailyLogsPage.dart';
import 'package:multi_page_form/multi_page_form.dart';

class SendDetailsPage extends StatefulWidget {
  @override
  _SendDetailsPageState createState() => _SendDetailsPageState();
}

int _currentStep = 0;

class _SendDetailsPageState extends State<SendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit Details',
          style: TextStyle(color: Colors.pink[100]),
        ),
        backgroundColor: Colors.white,
      ),
      // body: Form(
      //   child: MultiPageForm(
      //       totalPage: 3,
      //       pageList: [
      //         BasicInformationPage(),
      //         DailyLogsPage(),
      //         AttachementPage()
      //       ],
      //       onFormSubmitted: null,
      //       ),
      // ),
      body: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep >= 2) return;
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
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: Text('Basic Information'),
              content: BasicInformationPage(),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: Text('Daily Logs'),
              content: DailyLogsPage(),
            ),
            Step(
              isActive: _currentStep >= 2,
              title: Text('Attach Files'),
              content: AttachementPage(),
            ),
          ]),
    );
  }
}

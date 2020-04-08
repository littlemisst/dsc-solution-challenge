import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/updated-pages/profile/personal_information_1.dart';
import 'package:me_daily/updated-pages/profile/personal_information_2.dart';
import 'package:me_daily/updated-pages/profile/personal_information_addProfilePhoto.dart';

class UpdateProfileStepper extends StatefulWidget {
  @override
  _UpdateProfileStepperState createState() => _UpdateProfileStepperState();
}

class _UpdateProfileStepperState extends State<UpdateProfileStepper> {
  int _currentStep = 0;

  List<Step> get _steps => [
  Step(
  title: Text('Personal Information 1'), 
  content: PersonalInformation1(),
  state: _currentStep > 0 ? StepState.complete : StepState.editing
  ),
  Step(
  title: Text('Personal Information 2'), 
  content: PersonalInformation2(),
  state: _currentStep > 1 ? StepState.complete : StepState.editing
  ),
  Step(
  title: Text('Add Profile Photo'), 
  content: PersonalInformationAddPhoto(),
  state: _currentStep > 2 ? StepState.complete : StepState.editing
  ),
];
  int currentStep = 0;
  bool complete = false;

  void _onStepContinue() {
  }

  next() {
    currentStep == _steps.length - 1
        ? setState(() => complete = true)
        : goTo(currentStep + 1);
  }
  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }
  goTo(int step) {
    setState(() => currentStep = step);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stepper(
            steps: _steps,
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
          )
      )
    );
  }
}

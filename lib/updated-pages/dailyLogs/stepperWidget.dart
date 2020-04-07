import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget(this.currentStep, this.onStepContinue, this.onStepCancel, this.stepsList);
  final int currentStep;
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;
  final List stepsList;
  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: widget.currentStep,
      onStepContinue: widget.onStepContinue,
      onStepCancel: widget.onStepCancel,
      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(children: <Widget>[
          FlatButton(
            child: Icon(Icons.navigate_before),
            onPressed: onStepCancel
          ),
          FlatButton(
            child: Icon(Icons.navigate_next),
            onPressed: onStepContinue
          )
        ]);
      },
      steps: widget.stepsList,
      
    );
  }
}
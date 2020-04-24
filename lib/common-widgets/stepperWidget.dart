import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget(this.type, this.currentStep, this.onStepContinue, this.onStepCancel, this.stepsList);
  final StepperType type;
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
      type: widget.type,
      currentStep: widget.currentStep,
      onStepContinue: widget.onStepContinue,
      onStepCancel: widget.onStepCancel,
      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container(
          child: 
          Row(children: <Widget>[
            FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[300]), borderRadius: BorderRadius.circular(10)),
              child: Text('back'),
              onPressed: widget.currentStep == 0 ? null : onStepCancel
            ),
            SizedBox(width: 10),
            FlatButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor), borderRadius: BorderRadius.circular(10)),
              child: widget.currentStep == widget.stepsList.length - 1 ? Text('next') : Text('next', style: TextStyle(color: Colors.white)),
              onPressed: widget.currentStep == widget.stepsList.length - 1 ? null : onStepContinue
            )
          ])
        );
        
      },
      steps: widget.stepsList,
      
    );
  }
}
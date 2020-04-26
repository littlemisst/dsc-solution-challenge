import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/alertDialog.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/checkBoxContainer.dart';
import 'package:me_daily/common-widgets/expandedTextFieldWidget.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';
import 'package:me_daily/common-widgets/stepperWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/medicalHistory.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/incrementCardWidget.dart';
import 'package:me_daily/updated-pages/medicalHistoryPage/listBuilderWidget.dart';
import 'package:provider/provider.dart';

class EditMedicalHistoryPage extends StatefulWidget {
  @override
  _EditMedicalHistoryPageState createState() => _EditMedicalHistoryPageState();
}

class _EditMedicalHistoryPageState extends State<EditMedicalHistoryPage> {
  final _textController = TextEditingController();

  int _currentStep = 0;

  String _hospitalized;
  bool _hospitalizedValue;
  List<String> _choices = ['Yes', 'No'];

  int _hospitalizations;

  List<String> _foodAllergy;
  String _food;

  List<String> _drugAllergy;
  String _drug;

  List<String> _chronicDiseaseAdded;
  List<String> _immunizationAdded;

  List<String> _chronicDisease = Strings.chronicDiseaseList;
  List<bool> _chronicDiseaseValues = List<bool>();

  List<String> _immunization = Strings.immunizationsList;
  List<bool> _immunizationValues = List<bool>();


  void _increment() {
    setState(() => _hospitalizations++);
  }

  void _decrement() {
    setState(() => _hospitalizations--);
    if (_hospitalizations < 0) {
      _hospitalizations = 0;
    }
  }


  @override
  void initState() {
    final _currentData = Provider.of<List<MedicalHistory>>(context, listen: false);
    _hospitalizations = _currentData[0].hospitalizations;
    super.initState();
    _foodAllergy = [];
    _drugAllergy = [];
   _chronicDiseaseAdded = [];
   _immunizationAdded = [];

   setState(() {
      for (int i=0; i < _chronicDisease.length; i++) {
      _chronicDiseaseValues.add(false);
      }
      for (int i=0; i < _immunization.length; i++) {
      _immunizationValues.add(false);
      }
   });
  }

   MedicalHistory _historyFromState() {
     _hospitalized == 'Yes' ? _hospitalizedValue = true : _hospitalizedValue = false;
    return MedicalHistory(
      hospitalized: _hospitalizedValue,
      hospitalizations: _hospitalizations,
      foodAllergy: _foodAllergy,
      drugAllergy: _drugAllergy,
      chronicDisease: _chronicDiseaseAdded,
      immunizations: _immunizationAdded,
    );
  }

  Future<void> _setHistory(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final _history = _historyFromState();
    await _firestoreService.updateMedicalHistory(_history);
    Navigator.popAndPushNamed(context, Strings.profilePageRoute);
  }


  void _addFoodAllergy(value) {
    setState(() => _food = value);
    _textController.clear();
    return _foodAllergy.add(_food);
  }

   void _addDrugAllergy(value) {
    setState(() => _drug = value);
    _textController.clear();
    return _drugAllergy.add(_drug);
  }


  List<Step> get _steps => [
    Step(
      isActive: _currentStep >= 0,
      title: Text('Have you been hospitalized?'),
      content:  _buildHospitalizations(),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
    ),
    Step(
      isActive: _currentStep >= 1,
      title: Text('Food Allergies'),
      content:  _buildFoodAllergy(),
      state: _currentStep > 1 ? StepState.complete : StepState.editing
    ),
    Step(
      isActive: _currentStep >= 2,
      title: Text('Drug Allergies'),
      content: _buildDrugAllergy(),
      state: _currentStep > 2 ? StepState.complete : StepState.editing
    ),
    Step(
      isActive: _currentStep >= 3,
      title: Text('Chronic Diseases'),
      content: _buildChronicDisease(),
      state: _currentStep > 3 ? StepState.complete : StepState.editing
    ),
    Step(
      isActive: _currentStep >= 4,
      title: Text('Immunizations'),
      content: _buildImmunizations(),
      state: _currentStep > 4 ? StepState.complete : StepState.editing
    ),
  ];

  Widget _buildHospitalizations() {
    return _hospitalized != null && _hospitalized == _choices[0] ?
    IncrementCard(
      timesText: 'Times', 
      intText: _hospitalizations, 
      onPressedIncrement: () => _increment(),
      onPressedDecrement: ()=> _decrement())
    :
    ContentContainer(
      child: BuildRadioListView(_choices, _hospitalized, (value) => 
        setState(() => _hospitalized = value)),
    );

  }

  Widget _buildFoodAllergy() {
    final _currentData = Provider.of<List<MedicalHistory>>(context, listen: false);
    _foodAllergy = _currentData[0].foodAllergy;
    String allergy;
    return ContentContainer(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            ExpandedTextField('Add food', _textController, (value) => allergy = value),
            Column(children: <Widget>[
              FlatButton(
                child: Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
                onPressed: () => _addFoodAllergy(allergy)
              ),
              Text('ADD')
            ])
          ]),
          Container(child: ListBuilder(_foodAllergy)
          )
      ])
    ) 
    );
  }

  Widget _buildDrugAllergy() {
    final _currentData = Provider.of<List<MedicalHistory>>(context, listen: false);
    _drugAllergy = _currentData[0].drugAllergy;
    String allergy;
    return ContentContainer(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            ExpandedTextField('Drug', _textController, (value) => allergy = value),
            Column(children: <Widget>[
              FlatButton(
                child: Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
                onPressed: () => _addDrugAllergy(allergy)
              ),
              Text('ADD')
            ])
          ]),
          Container(child: ListBuilder(_drugAllergy)
          )
      ])
    ) 
    );
  }

  Widget _buildChronicDisease() {
    final _currentData = Provider.of<List<MedicalHistory>>(context, listen: false);
    _chronicDiseaseAdded = _currentData[0].chronicDisease;
    _chronicDiseaseAdded.forEach((element) {
      _chronicDiseaseValues[(_chronicDisease.indexOf(element))] = true;
      }); 
    return CheckBoxGrid(3.5, _chronicDisease, _chronicDiseaseValues, _chronicDiseaseAdded);
  }

  Widget _buildImmunizations() {
    final _currentData = Provider.of<List<MedicalHistory>>(context, listen: false);
    _immunizationAdded = _currentData[0].immunizations;
    _immunizationAdded.forEach((element) {
      _immunizationValues[(_immunization.indexOf(element))] = true;
      }); 
    return CheckBoxGrid(3.5, _immunization, _immunizationValues,_immunizationAdded);
  }


  void _onStepContinue() {
    setState(() =>  _currentStep ++);
  }

  void _onStepCancel() {
    if (_currentStep < 0) return;
    setState(() {
      _currentStep -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.profilePageRoute)),
        centerTitle: true,
        title: TextFormat('Medical History'),
      ),
      body: StepperWidget(StepperType.vertical, _currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps),
      floatingActionButton: _foodAllergy.isEmpty || _drugAllergy.isEmpty || _chronicDiseaseAdded.isEmpty || _immunizationAdded.isEmpty
      ? null :
      FloatingActionToSave(() async {
          final action = await Dialogs.showDialogBox(context, Strings.confirmChanges);
          if (action == DialogAction.yes) _setHistory(context);
        },
        Icons.check),
    );
  }
}
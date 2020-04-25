import 'package:flutter/material.dart';
import 'package:me_daily/model/medicalHistory.dart';
import 'package:me_daily/widgets/text_widget.dart';

class MedicalHistorySummary extends StatelessWidget {
  const MedicalHistorySummary({Key key, this.medicalHistory}) : super(key:key);
  final MedicalHistory medicalHistory;


  Widget _buildHospitalization() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Hospitalization')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text('${medicalHistory.hospitalizations}', style: TextStyle(fontSize: 15.0)))
    ]));
  }

  Widget _buildFoodAllergies() {
    String _foodAllergy;
    (medicalHistory.foodAllergy.length == 1) ? _foodAllergy = medicalHistory.foodAllergy[0]
    : _foodAllergy = medicalHistory.foodAllergy.join(', ');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Food Allergies')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(_foodAllergy, style: TextStyle(fontSize: 15.0)))
    ]));
  }

  Widget _buildDrugAllergies() {
    String _drugAllergy;
    (medicalHistory.drugAllergy.length == 1) ? _drugAllergy = medicalHistory.drugAllergy[0]
    : _drugAllergy = medicalHistory.foodAllergy.join(', ');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Drug Allergies')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(_drugAllergy, style: TextStyle(fontSize: 15.0)))
    ]));
  }

  Widget _buildChronicDiseases() {
    String _chronicDisease;
    (medicalHistory.chronicDisease.length == 1) ? _chronicDisease = medicalHistory.chronicDisease[0]
    : _chronicDisease = medicalHistory.chronicDisease.join(', ');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Chronic Disease')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(_chronicDisease, style: TextStyle(fontSize: 15.0)))
    ]));
  }

   Widget _buildImmunizations() {
    String _immunizations;
    (medicalHistory.immunizations.length == 1) ? _immunizations = medicalHistory.immunizations[0]
    : _immunizations = medicalHistory.immunizations.join(', ');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Immunizations')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(_immunizations, style: TextStyle(fontSize: 15.0)))
    ]));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
         SizedBox(height: 5),
         _buildHospitalization(),
         Divider(),
         _buildFoodAllergies(),
         Divider(),
         _buildDrugAllergies(),
         Divider(),
         _buildChronicDiseases(),
         Divider(),
         _buildImmunizations()
      ]),
      
    );
  }
}
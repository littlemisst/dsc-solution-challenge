import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/medicalHistory.dart';
import 'package:me_daily/widgets/medicalHistorySummaryBuilder.dart';

class MedicalHistorySummary extends StatelessWidget {
  const MedicalHistorySummary({Key key, this.medicalHistory}) : super(key:key);
  final MedicalHistory medicalHistory;


  Widget _buildHospitalization() {
    return ContentBuilder(text: Strings.hospitalizations, content: '${medicalHistory.hospitalizations}');
  }

  Widget _buildFoodAllergies() {
    String _foodAllergy;
    (medicalHistory.foodAllergy.length == 1) ? _foodAllergy = medicalHistory.foodAllergy[0]
    : _foodAllergy = medicalHistory.foodAllergy.join(', ');
    return ContentBuilder(text: Strings.foodAllergy, content: _foodAllergy);
  }

  Widget _buildDrugAllergies() {
    String _drugAllergy;
    (medicalHistory.drugAllergy.length == 1) ? _drugAllergy = medicalHistory.drugAllergy[0]
    : _drugAllergy = medicalHistory.foodAllergy.join(', ');
   return ContentBuilder(text: Strings.drugAllergy, content: _drugAllergy);
  }

  Widget _buildChronicDiseases() {
    String _chronicDisease;
    (medicalHistory.chronicDisease.length == 1) ? _chronicDisease = medicalHistory.chronicDisease[0]
    : _chronicDisease = medicalHistory.chronicDisease.join(', ');
    return ContentBuilder(text: Strings.chronicDisease, content: _chronicDisease);
  }

   Widget _buildImmunizations() {
    String _immunizations;
    (medicalHistory.immunizations.length == 1) ? _immunizations = medicalHistory.immunizations[0]
    : _immunizations = medicalHistory.immunizations.join(', ');
    return ContentBuilder(text: Strings.immunizations, content: _immunizations);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 5),
      _buildHospitalization(),
      Divider(),
      _buildFoodAllergies(),
      Divider(),
      _buildDrugAllergies(),
      Divider(),
      _buildChronicDiseases(),
      Divider(),
      _buildImmunizations(),
      Divider(),
  ]);
  }
}
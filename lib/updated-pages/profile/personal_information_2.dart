import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/widgets/height_weight_bloodType_widgets.dart';

class PersonalInformation2 extends StatefulWidget {
  @override
  _PersonalInformation2State createState() => _PersonalInformation2State();
}

class _PersonalInformation2State extends State<PersonalInformation2> {
  Profile _profile = Profile();
  ScrollController _weightController;
  ScrollController _heightController;
  String _bloodTypeValue;

  final metersController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
    kilogramController.addListener(() {
      _profile.weight = double.parse(kilogramController.text);
    });
    metersController.addListener(() {
      _profile.height = double.parse(metersController.text);
    });
  }
  @override
  void dispose() {
    metersController.dispose();
    kilogramController.dispose();
    super.dispose();
  }

  void _handleHeightScaleChanged(int scalePoints) {
    int inchOffest = scalePoints ~/ 20;
    double meters = inchOffest / 12;
    double roundOffMeters = double.parse((meters).toStringAsFixed(2));
    metersController.text = roundOffMeters.toString();
  }

  void _handleWeightScaleChanged(int scalePoints) {
    int gram = scalePoints ~/ 20;
    double kg = ((gram * 100) / 1000);
    kilogramController.text = kg.toString();
  }
  
  Widget _personalInformationForm2() {
    return  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeightScale(
                context, _heightController, _handleHeightScaleChanged),
            SizedBox(height: 12),
            buildHeightField(context, metersController),
            SizedBox(height: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildWeightScale(
                    context, _weightController, _handleWeightScaleChanged),
                SizedBox(height:12),
                buildWeightField(context, kilogramController),
                SizedBox(height: 12),
                buildBloodType(
                  context,
                  _profile.bloodType,
                  _bloodTypeValue,
                  (String value) => {
                    setState(() {
                      _bloodTypeValue = value;
                      _profile.bloodType = value;
                    })
                  },
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: _personalInformationForm2()
    );
  }
}
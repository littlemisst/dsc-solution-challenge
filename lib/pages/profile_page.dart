import 'package:flutter/material.dart';
import 'package:me_daily/api/home_page_api.dart';
import 'package:me_daily/api/profile_page_api.dart';
import 'package:me_daily/model/profile.dart';
import 'package:multi_page_form/multi_page_form.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  Profile _profile = Profile();
  String _ageValue;
  String _civilStatusValue;

  ScrollController _weightController;
  ScrollController _heightController;
  String _bloodTypeValue;

  final metersController = TextEditingController();
  final decimalsController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
    kilogramController.addListener(() {
      _profile.weight = kilogramController.text;
    });
    metersController.addListener(() {
      _profile.height = metersController.text;
    });
  }

  @override
  void dispose() {
    metersController.dispose();
    decimalsController.dispose();
    kilogramController.dispose();
    super.dispose();
  }

  Widget _buildNameField() {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Name',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (String value) => {_profile.name = value});
  }

  Widget _buildGender() {
    return Center(
        child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      items: [
        DropdownMenuItem<String>(child: Text('Male'), value: 'Male'),
        DropdownMenuItem<String>(child: Text('Female'), value: 'Female'),
      ],
      onChanged: (String value) => {
        setState(() {
          _ageValue = value;
          _profile.gender = value;
        })
      },
      hint: Text('Gender'),
      value: _ageValue,
    ));
  }

  Widget _buildAddressField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Address',
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: (String value) => {_profile.address = value},
    );
  }

  Widget _buildDatePicker() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: 'Birthdate',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (DateTime value) => {_profile.birthDate = value},
      ),
    ]);
  }

  Widget _buildCivilStatus() {
    return Container(
        child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      items: [
        DropdownMenuItem<String>(child: Text('Single'), value: 'Single'),
        DropdownMenuItem<String>(child: Text('Married'), value: 'Married'),
      ],
      onChanged: (String value) => {
        setState(() {
          _civilStatusValue = value;
          _profile.civilStatus = value;
        })
      },
      hint: Text('Civil Status'),
      value: _civilStatusValue,
    ));
  }

  Widget personalInformationPage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
      child: Column(children: <Widget>[
        Text('Personal Information', style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 30.0),
        _buildNameField(),
        SizedBox(height: 30.0),
        _buildGender(),
        SizedBox(height: 30.0),
        _buildAddressField(),
        SizedBox(height: 30.0),
        _buildDatePicker(),
        SizedBox(height: 30.0),
        _buildCivilStatus(),
      ]),
    );
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

  Widget _buildBloodType() {
    return Container(
      width: 150.0,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        items: [
          DropdownMenuItem<String>(child: Text('A+'), value: 'A+'),
          DropdownMenuItem<String>(child: Text('A-'), value: 'A-'),
          DropdownMenuItem<String>(child: Text('B+'), value: 'B+'),
          DropdownMenuItem<String>(child: Text('B-'), value: 'B-'),
          DropdownMenuItem<String>(child: Text('O+'), value: 'O+'),
          DropdownMenuItem<String>(child: Text('O-'), value: 'O-'),
          DropdownMenuItem<String>(child: Text('AB+'), value: 'AB+'),
          DropdownMenuItem<String>(child: Text('AB-'), value: 'AB-'),
        ],
        onChanged: (String value) => {
          setState(() {
            _bloodTypeValue = value;
            _profile.bloodType = value;
          })
        },
        hint: Text('Blood Type'),
        value: _bloodTypeValue,
      ),
    );
  }

  Widget _buildWeightField() {
    return Container(
      width: 120,
      height: 50.0,
      child: TextField(
        controller: kilogramController,
        style: TextStyle(fontSize: 22),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: '0', suffixText: 'kg', border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildHeightField() {
    return Container(
      height: 60.0,
      width: 120,
      child: TextField(
        controller: metersController,
        style: TextStyle(fontSize: 22),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: '0', suffixText: 'm', border: OutlineInputBorder()),
      ),
    );
  }

  Widget personalInformation2() {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Height',
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        HorizontalScale(
                          maxValue: 5,
                          scaleController: _heightController,
                          scaleColor: Colors.white10,
                          lineColor: Colors.pink[100],
                          linesBetweenTwoPoints: 11,
                          middleLineAt: 6,
                          textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.pink[100],
                              fontWeight: FontWeight.bold),
                          onChanged: _handleHeightScaleChanged,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                            _buildHeightField(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Weight',
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            HorizontalScale(
                              maxValue: 200,
                              scaleController: _weightController,
                              onChanged: _handleWeightScaleChanged,
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.pink[100],
                                  fontWeight: FontWeight.bold),
                              scaleColor: Colors.white10,
                              lineColor: Colors.pink[100],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            _buildWeightField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildBloodType(),
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget personalInformation3() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Container(
        child: Column(children: <Widget>[
      RaisedButton(
        child: Text('Sign Out'),
        // onPressed: () => signOut(authNotifier),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: MultiPageForm(
          totalPage: 3,
          pageList: <Widget>[
            personalInformationPage(),
            personalInformation2(),
            personalInformation3()
          ],
          onFormSubmitted: () {
            submitProfile(_profile);
          },
        ));
  }
}

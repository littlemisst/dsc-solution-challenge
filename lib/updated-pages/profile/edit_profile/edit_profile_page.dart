import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/widgets/edit_profile_widgets.dart';
import 'package:me_daily/widgets/height_weight_widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _initialGenderValue = 'Male';
  ScrollController _weightController;
  ScrollController _heightController;
  final metersController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          Profile _currentProfile = snapshots.data;
          kilogramController.addListener(() {
            _currentProfile.weight = double.parse(kilogramController.text);
          });
          metersController.addListener(() {
            _currentProfile.height = double.parse(metersController.text);
          });

          return Scaffold(
            appBar: AppBar(
              leading: FlatButton(
                child: Icon(Icons.arrow_back),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, Strings.profilePageRoute),
              ),
              title: Text('Edit Profile', style: TextStyle(color: Theme.of(context).primaryColor)),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: ContentContainer(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(children: <Widget>[
                    SizedBox(height: 10.0),
                    buildTextFormField(context, 'Name', _currentProfile.name,
                        (String value) {
                      _currentProfile.name = value;
                    }),
                    SizedBox(height: 15.0),
                    buildGender(context, _currentProfile.gender, _initialGenderValue, (String value) => {
                      setState(() {
                        _initialGenderValue = value;
                        _currentProfile.gender = _initialGenderValue;
                      }),
                      
                    }),
                    SizedBox(height: 15.0),
                    buildBloodType(context,  _currentProfile.bloodType, (String value) => {
                      setState(() {
                        _currentProfile.bloodType = value;
                    }),
                    }),
                    SizedBox(height: 15.0),
                    buildTextFormField(
                        context, 'Address', _currentProfile.address,
                        (String value) {
                        _currentProfile.address = value;
                    }),
                    SizedBox(height: 15.0),
                    buildDateTimePicker(context, _currentProfile.birthDate,
                        (DateTime value) {
                      _currentProfile.birthDate = value;
                    }),
                    SizedBox(height: 15.0),
                    buildCivilStatus(context, _currentProfile.civilStatus, (String value) => {
                        setState(() {
                          _currentProfile.civilStatus = value;
                      }),
                    }), 
                    SizedBox(height: 10.0),
                    Text('Height', style: TextStyle(color: Colors.grey[600])),
                    buildHeightScale(context, _heightController, _handleHeightScaleChanged),
                    SizedBox(height: 12),
                    buildHeightWeightField(context, metersController, _currentProfile.height.toString(), 'm'),
                    SizedBox(height: 18),
                    Text('Weight', style: TextStyle(color: Colors.grey[600])),
                    buildWeightScale(context, _weightController, _handleWeightScaleChanged),
                    SizedBox(height:12),
                    buildHeightWeightField(context, kilogramController, _currentProfile.weight.toString(), 'kg'),
                    SizedBox(height: 10.0),
                    RaisedButtonIcon(Icons.edit, 'Submit Edited Profile', (){
                      _firestoreService.submitProfile(_currentProfile);
                      Navigator.popAndPushNamed(context, Strings.profilePageRoute);
                      }
                    )
                  ]),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

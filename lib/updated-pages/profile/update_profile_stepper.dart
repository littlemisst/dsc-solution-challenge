import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/widgets/height_weight_bloodType_widgets.dart';
import 'package:me_daily/widgets/profile_widgets.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UpdateProfileStepper extends StatefulWidget {
  @override
  _UpdateProfileStepperState createState() => _UpdateProfileStepperState();
}

class _UpdateProfileStepperState extends State<UpdateProfileStepper> {
  Profile _profile = Profile();
   //----------------------------------------------- 
  String _ageValue;
  String _civilStatusValue;

  @override
  Widget _personalInformationForm1() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        buildNameField(context, _profile.name, (String value) {
          _profile.name = value;
        }),
        SizedBox(height: 10.0),
        buildGender(context, _profile.gender, _ageValue, (String value) => {
            setState(() {
              _ageValue = value;
              _profile.gender = value;
        })}),
        SizedBox(height: 10.0),
        buildBloodType(context, _profile.bloodType,_bloodTypeValue, (String value) => {
                setState(() {
                  _bloodTypeValue = value;
                  _profile.bloodType = value;
        })}),
        SizedBox(height: 10.0),
        buildAddressField(context, _profile.address, (String value) {
          _profile.address = value;
        }),
        SizedBox(height: 10.0),
        DatePicker('Birthdate', (DateTime value) {
          _profile.birthDate = value;
        }),
        SizedBox(height: 10.0),
        buildCivilStatus(context, _profile.civilStatus, _civilStatusValue, (String value) => {
            setState(() {
              _civilStatusValue = value;
              _profile.civilStatus = value;
        })}),
        SizedBox(height: 11.0),
      ]),
    );
  }
 //----------------------------------------------- 
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
          SizedBox(height: 20),
          buildHeightScale(context, _heightController, _handleHeightScaleChanged),
          SizedBox(height: 12),
          buildHeightField(context, metersController),
          SizedBox(height: 18),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildWeightScale(context, _weightController, _handleWeightScaleChanged),
              SizedBox(height:12),
              buildWeightField(context, kilogramController),
              SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
    );
  }
 //----------------------------------------------- 
  File _image;
  bool _uploaded = false;

  Future getImage(bool isCamera) async {
    File image;
    isCamera 
    ? image = await ImagePicker.pickImage(source: ImageSource.camera)
    : image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {_image = image;});
  }
  Future uploadImage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    String fileUploadName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    _profile.profilePhotoFileName = fileUploadName;
    StorageReference _reference = FirebaseStorage.instance
        .ref()
        .child('users/$uid/profilePhoto/${_profile.profilePhotoFileName}');
    StorageUploadTask uploadTask = _reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    _profile.downloadUrl = await _reference.getDownloadURL();
    setState(() {
      _uploaded = true;
    });
  }

  Widget _buildAddProfilePhoto() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          _image == null
              ? CircleAvatar(backgroundColor: Colors.grey, radius: 50.0)
              : CircleAvatar(
                  backgroundImage: new FileImage(_image), radius: 50.0),
          SizedBox(height: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.camera_alt, color: Colors.white),
            label: Text('Camera', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {getImage(true);},
          ),
          SizedBox(width: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.photo_album, color: Colors.white),
            label: Text('Gallery', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {getImage(false);},
          ),
          SizedBox(height: 30.0),
        ]),
      ),
    );
  }
 //----------------------------------------------- 
  int currentStep = 0;
  bool complete = false;

  List<Step> get _steps => [
    Step( title: Text('Personal Information 1'), 
    content: _personalInformationForm1()),
    Step( title: Text('Personal Information 2'), 
    content: _personalInformationForm2()),
    Step(title: Text('Add Profile Photo'), 
    content: _buildAddProfilePhoto()),
  ];

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
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stepper(
                steps: _steps,
                currentStep: currentStep,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
                controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
                  return Container(
                    child:  currentStep != _steps.length - 1 ? Row (children: <Widget>[
                      FlatButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[300])),
                        child: Text('back'),
                        onPressed: currentStep == 0 ? null : onStepCancel
                      ), SizedBox(width: 10),
                      FlatButton(
                        color: Colors.pink[100],
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pink[100])),
                        child: currentStep == _steps.length - 1 ? Text('next') : Text('next', style: TextStyle(color: Colors.white)),
                        onPressed: currentStep == _steps.length - 1 ? null : onStepContinue
                      )
                    ]) : FlatButton(child: Text('Submit Profile', style: TextStyle(color: Colors.white)), color: Colors.pink[100],
                    onPressed:() {_firestoreService.submitProfile(_profile);})
                  );
                },
              ),
             
          ],
        )
    );
  }
}

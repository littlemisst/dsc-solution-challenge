import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/stepperWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/widgets/dropDownWidget.dart';
import 'package:me_daily/widgets/heighScale.dart';
import 'package:me_daily/widgets/indicatorText.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:me_daily/widgets/textFormField_widget.dart';
import 'package:me_daily/widgets/weightScale.dart';
import 'package:provider/provider.dart';
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
  String _name;
  String _gender;
  String _genderValue;
  String _bloodType;
  String _address;
  DateTime _birthdate;
  String _civilStatus;
  String _civilStatusValue;
  double _height;
  double _weight;
  String _downloadURL;
  String _profilePhotoFileName;

  Profile _profileFromState() {
    return Profile(
      name: _name,
      address: _address,
      birthDate: _birthdate,
      gender: _gender,
      civilStatus: _civilStatus,
      bloodType: _bloodType,
      height: _height,
      weight: _weight,
      downloadUrl: _downloadURL,
      profilePhotoFileName: _profilePhotoFileName
    );
  }

   Future<void> _addProfile(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final profile = _profileFromState();
    await _firestoreService.submitProfile(profile);
    await uploadImage();
  }


  Profile _profile = Profile();
   //----------------------------------------------- 
  
  Widget _personalInformationForm1() {
    return  ContentContainer(
      width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
            IndicatorText('BASIC INFORMATION'),
            SizedBox(height: 10.0),
            TextFormFieldWidget(label: 'Full Name',  onChanged: (value) => _name = value), 
            SizedBox(height: 15.0),
            Row(children: <Widget>[
              Expanded(child: DatePicker('Birthdate', (DateTime value) => _birthdate = value)),
              SizedBox(width: 20),
              Expanded(
                child: DropDownWidget(label: 'Civil Status', items: Strings.civilStatusList, 
                  onChanged: (value) {
                    setState(() {
                      _civilStatusValue = value;
                      _civilStatus = value;
                    });
                  },
                initialValue: _civilStatusValue,
              )),
            ]),
            SizedBox(height: 15.0),
            Row(children: <Widget>[
              Expanded(child: DropDownWidget(label: 'Gender', items: Strings.genderList,
              onChanged: (value) {
                setState(() {
                  _genderValue = value;
                  _gender = value;
                });
              },
              initialValue: _genderValue,
              )),
              SizedBox(width: 20),
              Expanded(child: DropDownWidget(label: 'Blood Type', items: Strings.bloodTypeList,
                onChanged: (value) {
                  setState(() {
                    _bloodTypeValue = value;
                    _bloodType = value;
                  });
                },
                initialValue: _bloodTypeValue,
              )),
            ]),
            SizedBox(height: 15.0),
            TextFormFieldWidget(label: 'Complete Address', onChanged: (String value) => _address = value),
            SizedBox(height: 15.0),
          ])
        )
    );
  }
 //----------------------------------------------- 
  ScrollController _weightController;
  ScrollController _heightController;
  String _bloodTypeValue;
  final _metersController = TextEditingController();
  final _kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 20);
    _heightController = ScrollController(initialScrollOffset: 0);
    _kilogramController.addListener(() {
      _weight = double.parse(_kilogramController.text);
    });
    _metersController.addListener(() {
      _height = double.parse(_metersController.text);
    });
  }
  // @override
  // void dispose() {
  //   _metersController.dispose();
  //   _kilogramController.dispose();
  //   super.dispose();
  // }
  void _handleHeightScaleChanged(int scalePoints) {
    int inchOffest = scalePoints ~/ 20;
    double meters = inchOffest / 12;
    double roundOffMeters = double.parse((meters).toStringAsFixed(2));
    _metersController.text = roundOffMeters.toString();
  }
  void _handleWeightScaleChanged(int scalePoints) {
    int gram = scalePoints ~/ 20;
    double kg = ((gram * 100) / 1000);
    _kilogramController.text = kg.toString();
  }

  Widget _personalInformationForm2() {
    return ContentContainer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            HeightScale(textController: _metersController, scrollController: _heightController, scaleChanged: _handleHeightScaleChanged),
            SizedBox(height: 20),
            WeightScale(textController: _kilogramController, scrollController: _weightController, scaleChanged: _handleWeightScaleChanged)
          ],
        ),
      )
    );
  }
 //----------------------------------------------- 
  File _image;
  // bool _uploaded = false;

  Future getImage(bool isCamera) async {
    File image;
    isCamera 
    ? image = await ImagePicker.pickImage(source: ImageSource.camera)
    : image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {_image = image;});
  }

  Future uploadImage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    _profilePhotoFileName = fileUploadName;
      StorageReference _reference = FirebaseStorage.instance
      .ref()
      .child('users/${user.uid}/profilePhoto/${_profile.profilePhotoFileName}');
    StorageUploadTask uploadTask = _reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadURL = await _reference.getDownloadURL();
    _downloadURL = downloadURL;
  }
  
  Widget _buildAddProfilePhoto() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: ContentContainer(
        child: Container(
          padding: EdgeInsets.fromLTRB(50,25,50,20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            _image == null
                ? CircleAvatar(backgroundColor: Colors.grey, radius: 50.0)
                : CircleAvatar(
                    backgroundImage: new FileImage(_image), radius: 50.0),
            SizedBox(height: 20.0),
            Row(children: <Widget>[
              Expanded(child: FlatButtonIcon(Icons.camera_alt, 'Camera', () {
                setState(() {
                  String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                  _profilePhotoFileName = fileUploadName;
                });
                getImage(true);
              })),
              SizedBox(width: 20.0),
              Expanded(child: FlatButtonIcon(Icons.photo_album, 'Gallery', () {
                setState(() {
                  String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                  _profilePhotoFileName = fileUploadName;
                });  
                getImage(false);
              })),
              SizedBox(height: 30.0),
            ]),
          ])
            
        ),
      ),
    );
  }
 //----------------------------------------------- 
  int _currentStep = 0;
  bool complete = false;

  List<Step> get _steps => [
    Step(
    title: Text('Start'), 
    isActive: _currentStep >= 0,
    content: _personalInformationForm1(),
    state: _currentStep > 0 ? StepState.complete : StepState.editing),
    Step(
    title: Text('2'),
    isActive: _currentStep >= 1,
    content: _personalInformationForm2(),
    state: _currentStep > 1 ? StepState.complete : StepState.editing),
    Step(
    title: Text('End'),
    isActive: _currentStep >= 2,
    content: _buildAddProfilePhoto(),
    state: _currentStep > 2 ? StepState.complete : StepState.editing),
  ];

  void _next() {
    if (_currentStep == 0 && _name != null
    && _address != null && _bloodType != null && _birthdate != null
    && _gender != null && _civilStatus != null) {
      setState(() => _currentStep++);
    }
    if (_currentStep == 1 && _weight != null && _height != null){
      setState(() => _currentStep++);
    }
    if(_currentStep == 2 && _downloadURL != null && _profilePhotoFileName != null) {
      setState(() => _currentStep++);
    }
  }

   void _cancel() {
    if (_currentStep < 0) return;
      setState(() =>_currentStep --);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(canvasColor: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          children: <Widget>[
            Expanded(child: StepperWidget(
              StepperType.horizontal, _currentStep, () => _next(), () => _cancel(), _steps)),
          ],
        ),
      ),
      floatingActionButton: _currentStep == _steps.length -1 ? 
       FloatingActionToSave(() => _addProfile(context), Icons.check) : null
    );
  }
}



// Stepper(
//               type: StepperType.horizontal,
//               steps: _steps,
//               currentStep: _currentStep,
//               onStepContinue: _next,
//               onStepTapped: (step) => goTo(step),
//               onStepCancel: _cancel,
//               controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
//                 return Container(
//                   child:  _currentStep != _steps.length - 1 
//                   ? Row (children: <Widget>[
//                     FlatButtonWidget(
//                       color: Colors.white,
//                       child: Text('Back'),
//                       onPressed: _currentStep == 0 ? null : onStepCancel
//                     ), SizedBox(width: 10),
//                     FlatButtonWidget(
//                       color: Theme.of(context).primaryColor,
//                       child: _currentStep == _steps.length - 1 ? Text('Next') : Text('Next', style: TextStyle(color: Colors.white)),
//                       onPressed: _currentStep == _steps.length - 1 ? null : onStepContinue
//                     )
//                   ]) 
//                   : Row(
//                     children: <Widget>[
//                       _image == null ? Container() 
//                       : FlatButton(child: Text('Submit Profile', style: TextStyle(color: Colors.white)), color: Theme.of(context).primaryColor,
//                       onPressed:() async {
//                       await _firestoreService.submitProfile(_profile);
//                       await uploadImage();
//                       }),
                      
//                     ],
//                   ), 
//                 );
//               },
//             ),
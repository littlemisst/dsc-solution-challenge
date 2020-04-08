import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:multi_page_form/multi_page_form.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:me_daily/widgets/profile_widgets.dart';
import 'package:me_daily/widgets/height_weight_bloodType_widgets.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  Profile _profile = Profile();

  String _ageValue;
  String _civilStatusValue;
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

  File _image;
  bool _uploaded = false;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
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
          Text('Select Profile Photo'),
          SizedBox(height: 20.0),
          _image == null
              ? CircleAvatar(backgroundColor: Colors.grey, radius: 80.0)
              : CircleAvatar(
                  backgroundImage: new FileImage(_image), radius: 80.0),
          SizedBox(height: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.camera_alt, color: Colors.white),
            label: Text('Camera', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {
              getImage(true);
            },
          ),
          SizedBox(width: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.photo_album, color: Colors.white),
            label: Text('Gallery', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {
              getImage(false);
            },
          ),
        ]),
      ),
    );
  }

  Widget personalInformationForm1() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
      child: Column(children: <Widget>[
        Text('Personal Information', style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 30.0),
        buildNameField(context, _profile.name, (String value) {
          _profile.name = value;
        }),
        SizedBox(height: 30.0),
        buildGender(
          context,
          _profile.gender,
          _ageValue,
          (String value) => {
            setState(() {
              _ageValue = value;
              _profile.gender = value;
            })
          },
        ),
        SizedBox(height: 30.0),
        buildAddressField(context, _profile.address, (String value) {
          _profile.address = value;
        }),
        SizedBox(height: 30.0),
        DatePicker('Birthdate', (DateTime value) {
          _profile.birthDate = value;
        }),
        SizedBox(height: 30.0),
        buildCivilStatus(
          context,
          _profile.civilStatus,
          _civilStatusValue,
          (String value) => {
            setState(() {
              _civilStatusValue = value;
              _profile.civilStatus = value;
            })
          },
        ),
      ]),
    ));
  }

  Widget personalInformationForm2() {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Height',
              style: TextStyle(fontSize: 17, color: Colors.grey[600]),
            ),
            SizedBox(height: 15),
            buildHeightScale(
                context, _heightController, _handleHeightScaleChanged),
            SizedBox(height: 15),
            buildHeightField(context, metersController),
            SizedBox(height: 20),
            Text(
              'Weight',
              style: TextStyle(fontSize: 17, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildWeightScale(
                    context, _weightController, _handleWeightScaleChanged),
                SizedBox(height: 15),
                buildWeightField(context, kilogramController),
                SizedBox(height: 15),
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
      )),
    );
  }

  Widget personalInformationForm3() {
    return _buildAddProfilePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Form(
        key: _formKey,
        child: MultiPageForm(
          totalPage: 3,
          pageList: <Widget>[
            personalInformationForm1(),
            personalInformationForm2(),
            personalInformationForm3()
          ],
          onFormSubmitted: () async {
            await uploadImage();
            await _firestoreService.submitProfile(_profile);
          },
        ));
  }
}

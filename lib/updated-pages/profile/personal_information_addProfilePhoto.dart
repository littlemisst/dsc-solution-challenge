import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:me_daily/model/profile.dart';

class PersonalInformationAddPhoto extends StatefulWidget {
  @override
  _PersonalInformationAddPhotoState createState() => _PersonalInformationAddPhotoState();
}

class _PersonalInformationAddPhotoState extends State<PersonalInformationAddPhoto> {
  Profile _profile = Profile();
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
          _image == null
              ? CircleAvatar(backgroundColor: Colors.grey, radius: 50.0)
              : CircleAvatar(
                  backgroundImage: new FileImage(_image), radius: 50.0),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildAddProfilePhoto(),
    );
  }
}
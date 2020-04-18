import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class EditProfilePhoto extends StatefulWidget {
  @override
  _EditProfilePhotoState createState() => _EditProfilePhotoState();
}

class _EditProfilePhotoState extends State<EditProfilePhoto> {
  Profile _profile = Profile();
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
    String downloadURL = await _reference.getDownloadURL();
    _profile.downloadUrl = downloadURL;
    setState(() {
      _uploaded = true;
      _profile.downloadUrl = downloadURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          Profile _currentProfile = snapshots.data;
          
          return Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: ContentContainer(
            child: Container(
              padding: EdgeInsets.fromLTRB(50,25,50,20),
              child: Column(children: <Widget>[
                _image == null
                    ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 50.0)
                    : CircleAvatar(
                        backgroundImage: new FileImage(_image), radius: 50.0),
                SizedBox(height: 20.0),
                RaisedButtonIcon(Icons.camera_alt, 'Camera', () {
                  setState(() {
                    String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                    _profile.profilePhotoFileName = fileUploadName;
                  });
                  getImage(true);
                }),
                SizedBox(width: 20.0),
                RaisedButtonIcon(Icons.photo_album, 'Gallery', () {
                  setState(() {
                    String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                    _profile.profilePhotoFileName = fileUploadName;
                  });  
                  getImage(false);}),
                SizedBox(height: 30.0),
              ]),
            ),
          ),
        );
    }
    return Container();
  }
  );
  }
}
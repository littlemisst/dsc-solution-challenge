import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';

class EditProfilePhoto extends StatefulWidget {
  @override
  _EditProfilePhotoState createState() => _EditProfilePhotoState();
}

class _EditProfilePhotoState extends State<EditProfilePhoto> {
  File _image;
  bool _uploaded = false;
  String fileUploadName;

  Future getImage(bool isCamera) async {
    File image;
    isCamera 
    ? image = await ImagePicker.pickImage(source: ImageSource.camera)
    : image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {_image = image;});
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

          return Scaffold(
            appBar: AppBar(
              leading: FlatButton(
                child: Icon(Icons.arrow_back),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, Strings.profilePageRoute),
              ),
              title: Text('Change Profile Photo', style: TextStyle(color: Theme.of(context).primaryColor)),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: ContentContainer(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Column(children: <Widget>[

                    _image == null
                  ? CircleAvatar(backgroundImage: _currentProfile.downloadUrl == null 
                  ? Icon(Icons.add_a_photo, size: 50, color: Colors.blueGrey[100])
                  : NetworkImage(_currentProfile.downloadUrl) , 
                  backgroundColor: Colors.blueGrey[200], radius: 80.0)
                  : CircleAvatar(
                      backgroundImage: new FileImage(_image), radius: 80.0),
                  SizedBox(height: 20.0),
                  FlatButtonIcon(Icons.camera_alt, 'Camera', () {
                    setState(() {
                      String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                      _currentProfile.profilePhotoFileName = fileUploadName;
                    });
                    getImage(true);
                  }),
                  SizedBox(width: 20.0),
                  FlatButtonIcon(Icons.photo_album, 'Gallery', () {
                    setState(() {
                      String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                      _currentProfile.profilePhotoFileName = fileUploadName;
                    });  
                    getImage(false);}),
                  SizedBox(height: 30.0),
                  FlatButtonIcon(Icons.edit, 'Change Profile Photo', () async {
                        String fileUploadName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                        _currentProfile.profilePhotoFileName = fileUploadName;
                          StorageReference _reference = FirebaseStorage.instance
                          .ref()
                          .child('users/${user.uid}/profilePhoto/${_currentProfile.profilePhotoFileName}');
                        StorageUploadTask uploadTask = _reference.putFile(_image);
                        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                        String downloadURL = await _reference.getDownloadURL();
                        _currentProfile.downloadUrl = downloadURL;
                        await _firestoreService.submitProfile(_currentProfile);
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

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AttachementPage extends StatefulWidget {
  @override
  _AttachementPageState createState() => _AttachementPageState();
}

class _AttachementPageState extends State<AttachementPage> {
  String fileName;
  String downloadURL;
  String description;

  File _image;

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          _image == null ? Container() : Image.file(_image, height: 300.0),
          RaisedButton.icon(
            icon: Icon(Icons.camera_alt, color: Colors.white),
            label: Text('Camera', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {
              setState(() {
                fileName =
                    DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
              });
              getImage(true);
            },
          ),
          SizedBox(width: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.photo_album, color: Colors.white),
            label: Text('Gallery', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {
              setState(() {
                fileName =
                    DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
              });
              getImage(false);
            },
          ),
          SizedBox(height: 50.0),
          _image == null
              ? Container()
              : RaisedButton.icon(
                  icon: Icon(Icons.save_alt, color: Colors.white),
                  label: Text('Save', style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  onPressed: () async {
                    StorageReference _reference = FirebaseStorage.instance
                        .ref()
                        .child('users/${user.uid}/$fileName');

                    StorageUploadTask uploadTask = _reference.putFile(_image);
                    StorageTaskSnapshot taskSnapshot =
                        await uploadTask.onComplete;
                    downloadURL = await _reference.getDownloadURL();
                    await _firestoreService.uploadPhoto(
                        downloadURL, fileName, description);
                  },
                ),
        ]);
  }
}

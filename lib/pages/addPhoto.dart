import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  String fileName;
  String downloadURL;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Image',
          style: TextStyle(color: Colors.pink[100]),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(children: <Widget>[
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
          SizedBox(height: 10.0),
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
                    await _firestoreService.uploadPhoto(downloadURL, fileName);
                  },
                ),
        ]),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:me_daily/model/photos.dart';
import 'package:me_daily/api/add_photo_api.dart';

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  Photos _photos = Photos();

  bool _uploaded = false;
  File _image;
  String _downloadUrl;

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

  Future uploadImage(data) async {
    String fileUploadName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    _photos.fileName = fileUploadName;

    StorageReference _reference =
        FirebaseStorage.instance.ref().child(_photos.fileName);

    StorageUploadTask uploadTask = _reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    uploadPhoto(_photos);
    setState(() {
      _uploaded = true;
    });
  }

  // Future downloadImage() async {
  //   String downloadAddress = await _reference.getDownloadURL();
  //   setState(() {
  //     _downloadUrl = downloadAddress;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
              getImage(true);
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton.icon(
            icon: Icon(Icons.photo_album, color: Colors.white),
            label: Text('Gallery', style: TextStyle(color: Colors.white)),
            color: Colors.pink[100],
            onPressed: () {
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
                  onPressed: () {
                    uploadImage(_photos);
                  },
                ),
          _uploaded == false
              ? Container()
              : RaisedButton.icon(
                  icon: Icon(Icons.save_alt, color: Colors.white),
                  label: Text('Download Image',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  onPressed: () {
                    //downloadImage();
                  },
                ),
          _downloadUrl == null ? Container() : Image.network(_downloadUrl),
        ]),
      )),
    );
  }
}

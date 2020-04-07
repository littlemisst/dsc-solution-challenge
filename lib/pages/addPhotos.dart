import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:me_daily/widgets/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class AddPhotos extends StatefulWidget {
  @override
  _AddPhotosState createState() => new _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  String fileName;
  String downloadURL;
  String description;
  String _typeValue;
  File _image;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  bool selectMultiple = false;

  @override
  void initState() {
    super.initState();
  }

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

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#ffb8d2",
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#ffb8d2",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
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
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Switch(
                  value: selectMultiple,
                  onChanged: (bool newValue) {
                    setState(() {
                      selectMultiple = newValue;
                    });
                  }),
              Text('Select Multiple')
            ],
          ),
          selectMultiple == false
          ? Column(
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label:
                      Text('Camera', style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  onPressed: () {
                    setState(() {
                      fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                    });
                    getImage(true);
                  }),
                RaisedButton.icon(
                  icon: Icon(Icons.photo_album, color: Colors.white),
                  label: Text('Gallery',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  onPressed: () {
                    setState(() {
                      fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                    });
                    getImage(false);
                  })])
          : Column(
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.image, color: Colors.white),
                  label: Text('Gallery',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.pink[100],
                  onPressed: loadAssets,
                ), 
                SizedBox(height: 20)
                ]),
          selectMultiple == true
          ? Expanded(
              child: buildGridView(),
            )
            : Column(
              children: <Widget>[
                _image == null
                ? Container()
                : Column(children: <Widget>[
                  SizedBox(height: 20),
                    Image.file(_image, height: 200, width: 300),
                    SizedBox(height: 20),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0),
                      child: buildDescription( context, _typeValue, description,
                        (String value) => {
                          setState(() {
                            _typeValue = value;
                            description = value;
                          })
                        },
                    )),
                    
                    RaisedButton.icon(
                      icon: Icon(Icons.save_alt, color: Colors.white),
                      label: Text('Save', style: TextStyle(color: Colors.white)),
                      color: Colors.pink[100],
                      onPressed: () async {
                        StorageReference _reference = FirebaseStorage
                            .instance
                            .ref()
                            .child('users/${user.uid}/$fileName');
                        StorageUploadTask uploadTask =  _reference.putFile(_image);
                        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                        downloadURL = await _reference.getDownloadURL();
                        await _firestoreService.uploadPhoto(downloadURL, fileName, description);
                      },
                    ),
                  ])
                  ],
                )
        ],
      ),
    );
  }
}

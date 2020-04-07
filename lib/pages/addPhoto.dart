import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  String fileName;
  String downloadURL;
  String description;
  String _typeValue;
  bool selectMultiple = false;
  File _image;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

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
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#fcb6dd',
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#fcb6dd",
        ),
      );
    } on Exception catch (err) {
      error = err.toString();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 80,0, 0),
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          _image == null ? Container(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  maxRadius: 60,
                  child: Icon(Icons.add_a_photo, size: 60, color: Colors.white),
                ),
              SizedBox(height: 50.0),
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
                    loadAssets();
                  },
                ),
              ],
            ),
          ) : Image.file(_image, height: 300.0) ,
          SizedBox(height: 30.0),
         
          _image == null
          ? Container()
          : Column(
            children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  ),
                  items: [
                    DropdownMenuItem<String>(child: Text('Prescription'), value: 'Prescription'),
                    DropdownMenuItem<String>(child: Text('Receipt'), value: 'Receipt'),
                    DropdownMenuItem<String>(child: Text('Maintenance'), value: 'Maintenance'),
                    DropdownMenuItem<String>(child: Text('Laboratory Result'), value: 'Laboratory Result'),
                    DropdownMenuItem<String>(child: Text('Medical Certificate'), value: 'Medical Certificate'),
                    DropdownMenuItem<String>(child: Text('Others'), value: 'Others'),
                  ],
                  onChanged: (String value) => {
                    setState(() {
                      _typeValue = value;
                      description = value;
                    }) 
                  },
                  hint: Text('Add Description'),
                  value: _typeValue,
            ),
                ),
                SizedBox(height: 20),
              RaisedButton.icon(
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
                    await _firestoreService.uploadPhoto(downloadURL, fileName, description);
                  },
                ),
            ],
          ),
        ]),
      )),
    );
  }
}

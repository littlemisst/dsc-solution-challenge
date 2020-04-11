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
import 'package:me_daily/widgets/display_images_widget.dart';

class AddPhotos extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const AddPhotos({Key key, this.globalKey}) : super(key: key);
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
  List<String> imageUrls = <String>[];
  bool isUploaded = false;

  @override
  void initState() {
    super.initState();
  }

  Future getImage(bool isCamera) async {
    File image;
    isCamera
        ? image = await ImagePicker.pickImage(source: ImageSource.camera)
        : image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  
  Future<void> selectMultipleImages() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    selectMultiple = true;
    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        selectedAssets: images,
        maxImages: 300,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          useDetailsView: true,
          selectCircleStrokeColor: "#ffb8d2",
          actionBarColor: "#ffb8d2",
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
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

  Future<dynamic> postImage(Asset imageFile, firestoreService, user) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    StorageReference _reference = FirebaseStorage.instance.ref().child('users/${user}/$fileName');
    StorageUploadTask uploadTask = _reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    downloadURL = await _reference.getDownloadURL();
    if (downloadURL != null) {
      setState(() { isUploaded = true; });
    }
    await firestoreService.uploadPhoto(downloadURL, fileName, description);
    
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Container(  
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0), 
            child: Align(
              child: Material(
                color: Colors.white,
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    SizedBox(height: 50),
                    RaisedButton.icon(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        label: Text('Camera', style: TextStyle(color: Colors.white)),
                        color: Colors.pink[100],
                        onPressed: images.isEmpty ? () {
                          setState(() {
                            fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
                          });
                          getImage(true);
                          selectMultiple = false;
                        } : null),
                    SizedBox(width: 20),
                    RaisedButton.icon(
                      icon: Icon(Icons.image, color: Colors.white),
                      label: Text('Gallery', style: TextStyle(color: Colors.white)),
                      color: Colors.pink[100],
                      onPressed: _image == null ? selectMultipleImages : null,
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          isUploaded ? AlertDialog(title: Text('Add Image'), content: Text('Successfully Upload')) :Container(),
          _image == null && images.isEmpty ? Text('No image selected', style: TextStyle(color: Colors.grey[400])) :
          Text(_image == null ? images.length.toString() + ' images selected': '1 image selected',
          style: TextStyle(color: Colors.grey[400])),
          SizedBox(height: 20),
          images.isNotEmpty 
            ? Expanded(
                child: displayMultipleImages(images),
              )
            : Container(child: _image == null ? Container() : Image.file(_image, height: 200, width: 200)), 
          images.isNotEmpty || _image != null 
            ? Column(
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: buildDescription(context, _typeValue, description,
                      (String value) => {
                        setState(() {
                          _typeValue = value;
                          description = value;
                        })},
                    )),
              ],
            )
            
            : Container(),
          images.isNotEmpty && description != null
            ? RaisedButton.icon(
                icon: Icon(Icons.save_alt, color: Colors.white),
                label: Text('Save', style: TextStyle(color: Colors.white)),
                color: Colors.pink[100],
                onPressed: () async {
                  for (var imageFile in images) {
                    postImage(imageFile, _firestoreService, user.uid)
                      .then((downloadUrl) {
                      imageUrls.add(downloadUrl.toString());
                      if (imageUrls.length == images.length) {
                        if (downloadUrl != null && fileName != null && description != null) {
                          _firestoreService.uploadPhoto(downloadUrl, fileName, description);
                        }
                      }
                    });
                  }
                } 
              )
            : Container(),
          _image != null && description != null 
            ? RaisedButton.icon(
              icon: Icon(Icons.save_alt, color: Colors.white),
              label: Text('Save', style: TextStyle(color: Colors.white)),
              color: Colors.pink[100],
              onPressed: () async {
                StorageReference _reference = FirebaseStorage.instance
                    .ref()
                    .child('users/${user.uid}/$fileName');
                StorageUploadTask uploadTask = _reference.putFile(_image);
                StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                downloadURL = await _reference.getDownloadURL();
                if (downloadURL != null) {
                  setState(() { isUploaded = true; });
                }
                await _firestoreService.uploadPhoto(downloadURL, fileName, description);
                Navigator.of(context).pop();
              }) 
          : Container(),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}

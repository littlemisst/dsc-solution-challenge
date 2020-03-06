import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:me_daily/model/photos.dart';

class PhotoNotifier with ChangeNotifier{
  List<Photos> _photosList = [];
  Photos _currentPhoto;

  UnmodifiableListView<Photos> get photosList {
    UnmodifiableListView(_photosList);
  }

  Photos get currentPhoto => _currentPhoto;

  set photosList(List<Photos> photosList){
    _photosList = photosList;
    notifyListeners();
  }

  set currentPhoto(Photos photos){
    _currentPhoto = photos;
    notifyListeners();
  }
}
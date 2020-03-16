import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/photo.dart';

class FirestoreService {
  final String uid;
  FirestoreService({this.uid});

  final CollectionReference userData =
      Firestore.instance.collection('userData');

  List<Photo> _photoFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return Photo(
          fileName: document.data['fileName'],
          downloadURL: document.data['downloadURL']);
    }).toList();
  }

  Stream<List<Photo>> get photos {
    return userData.document(uid).collection('photos').snapshots().map(_photoFromFirebase);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot> getPhotos() async* {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  final _userId = currentUser.uid;
  yield* Firestore.instance
      .collection('userData')
      .document(_userId)
      .collection('photos')
      .snapshots();
}

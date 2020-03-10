import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

submitProfile(data) async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  final _userId = currentUser.uid;
  Firestore.instance
      .collection('userData')
      .document(_userId)
      .setData(data.toJson());
}

Stream<QuerySnapshot> getProfile() async* {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  final _userId = currentUser.uid;
  Firestore.instance.collection('userData').document(_userId).get().asStream();
}

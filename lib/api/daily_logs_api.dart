import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


submit(data) async {
   FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
   final _userId = currentUser.uid;
  Firestore.instance.collection('userData').document(_userId).collection('logs').add(data.toJson());
}
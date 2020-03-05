import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = Firestore.instance;

uploadPhoto(data) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  await db
      .collection('userData')
      .document(uid)
      .collection('photos')
      .add(data.toJson());
}

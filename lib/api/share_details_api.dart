import 'package:cloud_firestore/cloud_firestore.dart';

submitDetails(data) async {
  Firestore.instance
      .collection('mockmessage')
      .add(data.toJson());
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/updated-pages/photos/gallery_grid.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/services/firestore_service.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Photo>>.value(
      value: FirestoreService(uid: 'bM9aIx9vHVfYu5dMTulw2ll18AJ2').photos,
      child: Container(
        child: GalleryGrid(),
      ),
    );
  }
}

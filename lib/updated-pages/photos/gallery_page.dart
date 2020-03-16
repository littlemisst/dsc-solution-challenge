import 'package:flutter/material.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/updated-pages/photos/gallery_grid.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/services/firestore_service.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Photo>>.value(
      value: FirestoreService(uid: user.uid).photos,
      child: Container(
        child: GalleryGrid(),
      ),
    );
  }
}

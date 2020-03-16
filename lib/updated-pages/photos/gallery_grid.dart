import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/model/photo.dart';
import 'package:provider/provider.dart';

class GalleryGrid extends StatefulWidget {
  @override
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  @override
  Widget build(BuildContext context) {
    final photos = Provider.of<List<Photo>>(context);

    return Container(
        child: GridView.builder(
      itemCount: photos.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) =>
          _buildPhotoListItem(context, photos[index]),
    ));
  }
}

Widget _buildPhotoListItem(context, document) {
  return Container(
    child: Image.network(
      document.downloadURL.toString(),
      fit: BoxFit.cover,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/updated-pages/photos/full_screen.dart';
import 'package:provider/provider.dart';

class GalleryGrid extends StatefulWidget {
  @override
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  @override
  Widget build(BuildContext context) {
    List<Photo> photos = Provider.of<List<Photo>>(context);

    if (photos == null) {
      photos = [];
    }

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
    child: GestureDetector(
        child: GridTile(
          footer: Text(document.fileName),
          child: Hero(
            tag: document.fileName,
            child: Image.network(
              document.downloadURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return FullScreen(
              imageURL: document.downloadURL,
              tag: document.fileName,
            );
          }));
        }),
  );
}

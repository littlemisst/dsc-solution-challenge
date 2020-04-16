import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/photos/full_screen.dart';
import 'package:me_daily/updated-pages/photos/sliverDelegate.dart';
import 'package:me_daily/model/photo.dart';
import 'package:provider/provider.dart';

class GalleryGrid extends StatelessWidget {

  SliverPersistentHeader makeHeader(String headerText, Color color) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 20.0,
        maxHeight: 30.0,
        child: Container(
        color: color, child: Center(child: Text(headerText, style: TextStyle(color: Colors.white)))),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Photo> photos = Provider.of<List<Photo>>(context);
     if (photos == null) {
      photos = [];
    }
    return CustomScrollView(
      slivers: <Widget>[
        makeHeader('Prescriptions', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          children: [
            GridView.builder(
              itemCount: photos.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) =>
                  _buildPhotoListItem(context, photos[index]),
            )
          ],
        ),
        makeHeader('Maintenance', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 3,
          children: [
            Container(color: Colors.red, height: 150.0),
            Container(color: Colors.purple, height: 150.0),
            Container(color: Colors.green, height: 150.0),
            Container(color: Colors.orange, height: 150.0),
            Container(color: Colors.yellow, height: 150.0),
            Container(color: Colors.pink, height: 150.0),
            Container(color: Colors.cyan, height: 150.0),
            Container(color: Colors.indigo, height: 150.0),
            Container(color: Colors.blue, height: 150.0),
          ],
        ),
      ],
    );
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
}
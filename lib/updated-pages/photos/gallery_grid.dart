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
        makeHeader('${photos.length} Photos ', Colors.blueGrey[200]),
        makeHeader('Prescriptions', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 1,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(photos.length, (index) => 
                  _buildPhotoListItem(context, photos[index]),
                )
              ),
            )
          ],
        ),
        makeHeader('Receipts', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 2,
          children: [
            
          ],
        ),
        makeHeader('Maintenance', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 2,
          children: [
           
          ],
        ),
        makeHeader('Laboratory Results', Theme.of(context).primaryColor),
       SliverGrid.count(
          crossAxisCount: 2,
          children: [
           
          ],
        ),
        makeHeader('Medical Certificates', Theme.of(context).primaryColor),
        SliverGrid.count(
          crossAxisCount: 2,
          children: [
           
          ],
        ),
       makeHeader('Others', Theme.of(context).primaryColor),
       SliverGrid.count(
          crossAxisCount: 2,
          children: [
            
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
import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/photos/full_screen.dart';
import 'package:me_daily/updated-pages/photos/grid_view_count.dart';
import 'package:me_daily/updated-pages/photos/sliver_delegate.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/updated-pages/photos/sliver_grid_count.dart';
import 'package:provider/provider.dart';

class GalleryGrid extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
    List<Photo> photos = Provider.of<List<Photo>>(context);
    List<Photo> prescriptions = [];
    List<Photo> receipts = [];
    List<Photo> maintenance = [];
    List<Photo> laboratoryResults = [];
    List<Photo> medicalCertificates = [];
    List<Photo> others = [];
    
    if (photos == null) {
      photos = [];
    }
    
    for (var photo in photos) {
      if (photo.description == 'Prescription') {
        prescriptions.add(photo);
      }
      else if (photo.description == 'Receipt') {
        receipts.add(photo);
      }
      else if (photo.description == 'Maintenance') {
        maintenance.add(photo);
      }
      else if (photo.description == 'Laboratory Result') {
        laboratoryResults.add(photo);
      }
      else if (photo.description == 'Medical Certificate') {
        medicalCertificates.add(photo);
      }
      else {
        others.add(photo);
      }
    }

    return CustomScrollView(
      slivers: <Widget>[
        header('Total of ${photos.length} Photos ', Colors.blueGrey[200]),
        header('Prescriptions', Theme.of(context).primaryColor),
        SliverGridCount(children: [
            prescriptions.isEmpty ? noAvailable()
            : GridViewCount(children: List.generate(prescriptions.length, (index) => 
            _buildPhotoListItem(context, prescriptions[index]),
          ))]
        ),
        header('Receipts', Theme.of(context).primaryColor),
        SliverGridCount(children: [
            receipts.isEmpty ? noAvailable()
            : GridViewCount(children: List.generate(receipts.length, (index) => 
            _buildPhotoListItem(context, receipts[index]),
            ))],
        ),
        header('Maintenance', Theme.of(context).primaryColor),
        SliverGridCount( children: [
            maintenance.isEmpty ? noAvailable()
            : GridViewCount(children: List.generate(maintenance.length, (index) => 
            _buildPhotoListItem(context, maintenance[index]),
            ))],
        ),
        header('Laboratory Results', Theme.of(context).primaryColor),
        SliverGridCount( children: [
              laboratoryResults.isEmpty ? noAvailable()
              : GridViewCount(children: List.generate(laboratoryResults.length, (index) => 
              _buildPhotoListItem(context, laboratoryResults[index]),
              ))],
          ),
        header('Medical Certificates', Theme.of(context).primaryColor),
        SliverGridCount(children: [
            medicalCertificates.length == 0 ? noAvailable()
            : GridViewCount(children: List.generate(medicalCertificates.length, (index) => 
            _buildPhotoListItem(context, medicalCertificates[index]),
            ))],
        ),
        header('Others', Theme.of(context).primaryColor),
        SliverGridCount( children: [
            others.isEmpty ? noAvailable()
            :GridViewCount(children: List.generate(others.length, (index) => 
            _buildPhotoListItem(context, others[index])
            ))],
        ),
      ],
    );
  }

  Widget noAvailable() {
    return Row (mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[Icon(Icons.photo, color: Colors.blueGrey[200] ),
    Text('No Photo Available', style: TextStyle(color: Colors.blueGrey[200]))
    ]); 
  }

  SliverPersistentHeader header(String headerText, Color color) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 20.0,
        maxHeight: 40.0,
        child: Container(
        color: color, child: Center(child: Text(headerText , 
        style: TextStyle(color: Colors.white)))),
      ),
    );
  }

  Widget _buildPhotoListItem(context, document) {
    return Container(
      child: GestureDetector(
      child: GridTile(
        footer: Container(child: Text('File name: ${document.fileName}', style: TextStyle(fontSize: 8)), 
        color: Colors.white),
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
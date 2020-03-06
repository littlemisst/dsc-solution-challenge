import 'package:flutter/material.dart';
import 'package:me_daily/api/retrieve_photos.dart';
import 'package:me_daily/model/photo.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

Widget _buildPhotoListItem(context, document) {
  return Container(
    child: Image.network(
      document['downloadURL'].toString(),
      fit: BoxFit.cover,
    ),
  );
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getPhotos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading');
          }

          return GridView.builder(
            itemCount: snapshot.data.documents.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) =>
                _buildPhotoListItem(context, snapshot.data.documents[index]),
          );
        });
  }
}

// class _FilesState extends State<Files> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         crossAxisCount: 2,
//         children: List.generate(100, (index) {
//           return Center(
//             child: Text(
//               'Item $index',
//               style: Theme.of(context).textTheme.headline,
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

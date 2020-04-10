import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
  
  Widget displayMultipleImages(imagesList) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20 ),
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(imagesList.length, (index) {
          Asset asset = imagesList[index];
          return AssetThumb(
            asset: asset,
            height: 300,
            width: 300,
          );
        }),
      ),
    );
  }
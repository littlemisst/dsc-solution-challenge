class Photo {
  final String fileName;
  final String downloadURL;
  final String description;

  Photo({this.fileName, this.downloadURL, this.description});

  // Map<String, dynamic> toJson() =>
  //     {"fileName": fileName, "downloadURL": downloadURL};
}

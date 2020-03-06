class Photo {
  String fileName;
  String downloadURL;

  Photo();

  Map<String, dynamic> toJson() => {
    "fileName" : fileName,
    "downloadURL": downloadURL
  };
}

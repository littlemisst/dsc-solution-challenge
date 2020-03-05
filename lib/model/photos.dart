class Photos {
  String fileName;
  String downloadURL;

  Photos();

  Map<String, dynamic> toJson() => {
    "fileName" : fileName,
    "downloadURL": downloadURL
  };
}

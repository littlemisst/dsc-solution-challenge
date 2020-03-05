class Photos {
  String fileName;

  Photos();

  Map<String, dynamic> toJson() => {
    "fileName" : fileName,
  };
}

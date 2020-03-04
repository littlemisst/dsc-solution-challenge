class Logs {
  String emotion;
  String note;

  Logs();

  Map<String, dynamic> toJson()=>{
    "emotion": emotion,
    "note":note
  };
}

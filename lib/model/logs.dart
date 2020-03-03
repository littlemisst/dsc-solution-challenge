class Logs {
  String emotion;
  String medicine;

  Logs();

  Map<String, dynamic> toJson()=>{
    "emotion": emotion,
    "medicine":medicine
  };
}
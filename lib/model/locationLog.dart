class LocationLog {
  String locationName;
  DateTime dateAndTime;

  LocationLog({this.locationName, this.dateAndTime});

  Map<String, dynamic> toJson() => {
        "locationName": locationName,
        "dateAndTime": dateAndTime,
      };
}

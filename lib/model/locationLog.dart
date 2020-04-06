class LocationLog {
  String locationName;

  LocationLog({this.locationName});

  Map<String, dynamic> toJson() => {
        "locationName": locationName,
      };
}

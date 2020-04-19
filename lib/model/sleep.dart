class Sleep {
  final int hoursSleep;
  final DateTime dateTime;

  Sleep({this.hoursSleep, this.dateTime});

  Map<String, dynamic> toJson() =>
      {"hoursSleep": hoursSleep, "dateTime": dateTime};
}

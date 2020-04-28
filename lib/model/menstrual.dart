class Menstrual {
  final DateTime periodStarts;
  final DateTime periodEnds;
  final String flow;
  final String cycle;

  Menstrual({this.periodStarts, this.periodEnds, this.flow, this.cycle});

  Map<String, dynamic> toJson() =>
      {"periodStarts": periodStarts, "periodEnds": periodEnds, "flow" : flow, "cycle" : cycle};
}

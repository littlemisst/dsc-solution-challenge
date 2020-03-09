class Health{
  String feeling;
  int count;

  Health(this.feeling, this.count);

  Health.fromMap(Map<String , dynamic> map)
  :assert(map['feeling']!=null),
  assert(map['count']!=null),
    feeling = map['feeling'],
    count = map['count'];
}
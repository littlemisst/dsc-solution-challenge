class Profile {
  String name;
  String address;
  String civilStatus;
  DateTime birthDate;
  int numberOfHospitalizations;

  Profile();

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "civilStatus": civilStatus,
        "birthDate": birthDate,
        "numberOfHospitalizations": numberOfHospitalizations
      };
}

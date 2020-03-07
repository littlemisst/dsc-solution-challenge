class Profile {
  String name;
  String address;
  String civilStatus;
  String gender;
  DateTime birthDate;
  int numberOfHospitalizations;

  Profile();

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "civilStatus": civilStatus,
        "gender": gender,
        "birthDate": birthDate,
        "numberOfHospitalizations": numberOfHospitalizations
      };
}

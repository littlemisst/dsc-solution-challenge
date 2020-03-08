class Profile {
  String name;
  String address;
  String civilStatus;
  String gender;
  DateTime birthDate;
  int numberOfHospitalizations;
  String bloodType;

  Profile();

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "civilStatus": civilStatus,
        "gender": gender,
        "birthDate": birthDate,
        "numberOfHospitalizations": numberOfHospitalizations,
        "bloodType": bloodType,
      };
}

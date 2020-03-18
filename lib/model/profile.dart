class Profile {
  String name;
  String address;
  String civilStatus;
  String gender;
  DateTime birthDate;
  // int numberOfHospitalizations;
  String bloodType;
  String height;
  String weight;
  String profilePhotoFileName;
  String downloadUrl;

  Profile({this.name, this.address, this.gender, this.civilStatus, this.bloodType, this.height, this.weight});

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "civilStatus": civilStatus,
        "gender": gender,
        "birthDate": birthDate,
        // "numberOfHospitalizations": numberOfHospitalizations,
        "bloodType": bloodType,
        "height": double.parse(height),
        "weight": double.parse(weight),
        "profilePhotoFileName": profilePhotoFileName,
        "downloadUrl" : downloadUrl,
      };
}

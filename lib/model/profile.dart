class Profile {
  String name;
  String address;
  String civilStatus;
  String gender;
  DateTime birthDate;
  // int numberOfHospitalizations;
  String bloodType;
  double height;
  double weight;
  String profilePhotoFileName;
  String downloadUrl;

  Profile(
      {this.name,
      this.address,
      this.birthDate,
      this.gender,
      this.civilStatus,
      this.bloodType,
      this.height,
      this.weight,
      this.downloadUrl,
});

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "civilStatus": civilStatus,
        "gender": gender,
        "birthDate": birthDate ,
        // "numberOfHospitalizations": numberOfHospitalizations,
        "bloodType": bloodType,
        "height": height,
        "weight": weight,
        "profilePhotoFileName": profilePhotoFileName,
        "downloadUrl": downloadUrl,
        
      };
}

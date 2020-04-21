import 'package:me_daily/constants/strings.dart';

class CheckBloodPressure {
  CheckBloodPressure(this.systolic, this.diastolic);
  final int systolic;
  final int diastolic;

  String get diagnosis {
    String _diagnosis;
    print('naglabay diri... systolic is $systolic');
    if (systolic < 120 && diastolic < 80) {
      _diagnosis = Strings.normal;
    } else if (systolic < 140 && diastolic < 90) {
      _diagnosis = Strings.preHypertension;
    } else if (systolic < 160 && diastolic < 100) {
      _diagnosis = Strings.stage1;
    } else if (systolic < 180 && diastolic < 120) {
      _diagnosis = Strings.stage2;
    } else if (systolic > 180 && diastolic > 120) {
      _diagnosis = Strings.hyperEmergency;
    }
    return _diagnosis;
  }
}
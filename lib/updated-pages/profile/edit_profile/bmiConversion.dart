import 'dart:math';

class BMIConversion {
  BMIConversion(this.weight, this.height);

  final double weight;
  final double height;

  double get bmi {
    double bmi = weight / pow(height, 2);
    return bmi;
  }

  String get bmiCategory {
    String _bmiCategory;
     
    if (bmi <= 0) {
      _bmiCategory = 'Invalid';
    } else if (bmi < 18.5) {
      _bmiCategory = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      _bmiCategory = 'Normal';
    } else if (bmi >= 25 && bmi <= 29.9) {
      _bmiCategory = 'Overweight';
    } else if (bmi >= 30) {
      _bmiCategory = 'Obese';
    }
    return _bmiCategory;
  }
   
}


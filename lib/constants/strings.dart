import 'package:flutter/material.dart';

class Strings {
  static const profile = 'Profile';
  static const medicalHistory = 'Past Medical History';
  static const message = 'Messages';
  static const shareDetails = 'Share Details';
  static const help = 'Help';
  static const signOut = 'Sign Out';

  static const foodList = [
    'vegetables',
    'fruits',
    'grains',
    'dairy',
    'meat',
    'poultry',
    'fish',
    'eggs',
    'no meat',
    'no sweets',
  ];
  static const drinkList = [
    "water",
    "coffee",
    "milk",
    "tea",
    "soda",
    "no soda",
    "no coffee"
  ];
  static const medicineList = [
    "for fever",
    "for common cold",
    "maintenance",
    "for diarrhea",
    "for sore throat",
    "for allergies",
    "vitamins"
  ];
  static const exerciseList = ["walk", "jog", "weights", "cycle", "yoga"];
  static const appointmentList = [
    "routine check-up",
    "laboratory",
    "counseling",
    "vaccination",
    "sick visit",
    "eye care",
    "dental"
  ];

  static const symptomsList = [
    'headache',
    'dizziness',
    'fever',
    'runny nose',
    'cough',
    'diarrhea',
    'vomiting',
    'muscle pain',
  ];

  static const chronicDiseaseList = [
    'Alzheimer disease',
    'Arthritis',
    'Asthma',
    'Cancer',
    'COPD',
    'Crohn disease',
    'Diabetes',
    'Epilepsy',
    'Heart disease',
    'HIV/AIDS',
    'Hypertension',
    'Multiple sclerosis',
    'None'
  ];

  static const immunizationsList = [
    'Varicella vaccine',
    'DTaP',
    'HepA',
    'HepB',
    'Hib vaccine'
        'HPV',
    'Flu',
    'MMR',
    'IPV',
    'PCV',
    'None'
  ];

  static const eat = 'Eat';
  static const drink = 'Drink';
  static const exercise = 'Exercise';
  static const medicine = 'Take Medicine';
  static const appointment = 'Book an Appointment';
  static const more = 'More';

  static const good = 'Good';
  static const okay = 'Okay';
  static const unwell = 'Unwell';
  static const sick = 'Sick';

  static const systolic = 'Systolic';
  static const diastolic = 'Diastolic';
  static const record = 'Record';

  static const normal = 'Normal';
  static const preHypertension = 'Prehypertension';
  static const stage1 = 'Stage 1 Hypertension';
  static const stage2 = 'Stage 1 Hypertension';
  static const hyperEmergency = 'Hypertensive Emergency';

  static const civilStatusList = [
    DropdownMenuItem<String>(child: Text('Single'), value: 'Single'),
    DropdownMenuItem<String>(child: Text('Married'), value: 'Married'),
  ];

  static const genderList = [
    DropdownMenuItem<String>(child: Text('Male'), value: 'Male'),
    DropdownMenuItem<String>(child: Text('Female'), value: 'Female'),
  ];

  static const bloodTypeList = [
    DropdownMenuItem<String>(child: Text('A+'), value: 'A+'),
    DropdownMenuItem<String>(child: Text('A-'), value: 'A-'),
    DropdownMenuItem<String>(child: Text('B+'), value: 'B+'),
    DropdownMenuItem<String>(child: Text('B-'), value: 'B-'),
    DropdownMenuItem<String>(child: Text('O+'), value: 'O+'),
    DropdownMenuItem<String>(child: Text('O-'), value: 'O-'),
    DropdownMenuItem<String>(child: Text('AB+'), value: 'AB+'),
    DropdownMenuItem<String>(child: Text('AB-'), value: 'AB-'),
  ];

  //hospitalization strings
  static const hospitalizations = 'Hospitalizations';
  static const foodAllergy = 'Food Allergies';
  static const drugAllergy = 'Drug Allergies';
  static const chronicDisease = 'Chronic Disease';
  static const immunizations = 'Immunizations';

  //dialog
  static const confirmTask = 'Do you want to add this task?';
  static const confirmLog = 'Do you want to add this log?';
  static const confirmChanges = "Do you want to save changes?";
  static const confirmRecord = "Do you want to record this?";

  static const String initialRoute = '/';
  static const String authenticationRoute = '/authentication';
  static const String signInRoute = '/sign-in';
  static const String verificationRoute = '/verification';
  static const String resetPasswordRoute = '/reset-password';
  static const String sendDetailsRoute = '/send-details';
  static const String addTaskRoute = '/add-task';
  static const String taskViewItemsRoute = '/task-view-items';
  static const String addPhotoRoute = '/add-photo';
  static const String addDailyLogRoute = '/add-daily-log';
  static const String locationLogSummary = '/location-log-summary';
  static const String mapPage = '/map';
  static const String basicQuestionsLogRoute = '/basic-questions-log';
  static const String sickQuestionsLogRoute = '/sick-questions-log';
  static const String profilePageRoute = '/profile-page';
  static const String editProfilePageRoute = '/edit-profile-page';
  static const String editProfilePhotoPageRoute = '/edit-profile-photo-page';
  static const String summaryPageRoute = '/summary-page';
  static const String resetPasswordFormRoute = '/reset-password-form';
  static const String messagesPage = '/messages-page';
  static const String onBoardingRoute = '/on_boarding-pages';
  static const String helpPage = '/help-page';
  static const String menstrualPeriodHistoryPage = '/menstrual-period-history-page';
  static const String waterHistoryPage = '/water-history-page';
  static const String bpHistoryPage = '/bp-history-page';
  static const String temperatureHistoryPage = '/temperature-history-page';
  static const String medicalHistoryPage = '/medical-history-page';
  static const String editMedicalHistoryPage = '/edit-medical-history-page';
  static const String viewMessage = '/view-message';
}

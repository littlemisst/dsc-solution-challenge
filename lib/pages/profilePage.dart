import 'package:flutter/material.dart';
import 'package:me_daily/api/home_page_api.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: Column(children: <Widget>[
        ProfileForm(),
        RaisedButton(
          child: Text('Sign Out'),
          onPressed: () => signOut(authNotifier),
        ),
      ]),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Name',
        ));
  }
  Widget _buildAgeField() {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) { //---------------ADD VALIDATION THAT THE INPUT SHOULD STRICTLY BE A NUMBER
            return 'Please enter a number';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Age',
        ));
  }

  Widget _buildAddressField() {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Address',
        ));
  }

  Widget _buildCivilStatusDropDown(dropdownValue) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.keyboard_arrow_down),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Single', 'Married', 'Widowed']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget _buildBirthdayDropDown(month,day, year) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<String>(
          value: month,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: (String newValue) {
            setState(() {
              month = newValue;
            });
          },
          items: <String>['January', 'February', 'March', 'April','May','June','July',
          'August','September','October','November','December']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: day,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: (String newValue) {
            setState(() {
              day = newValue;
            });
          },
          items: <String>['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15',
          '16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'
          ]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: year,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: (String newValue) {
            setState(() {
              year = newValue;
            });
          },
          items: <String>['2000', '2001', '2002','2003','2004','2005','2006','2007','2008','2009','2010','2011',
          '2012','2013','2014','2015','2016','2017','2018','2019','2020']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    ); 
  }

  Widget _buildNumberofHospitalizationsDropDown(initialNumber) {
    return DropdownButton<String>(
      value: initialNumber,
      icon: Icon(Icons.keyboard_arrow_down),
      onChanged: (String newValue) {
        setState(() {
          initialNumber = newValue;
        });
      },
      items: <String>['Once', 'Twice', 'Thrice','More than thrice']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          _buildNameField(),
          _buildAgeField(),
          _buildAddressField(),
          _buildCivilStatusDropDown('Single'),
          _buildBirthdayDropDown('January','1', '2000'),
          _buildNumberofHospitalizationsDropDown('Once'),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit')))
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/widgets/edit_profile_widgets.dart';
import 'package:me_daily/widgets/height_weight_widgets.dart';

class EditHeightAndWeightPage extends StatefulWidget {
  @override
  _EditHeightAndWeightPageState createState() => _EditHeightAndWeightPageState();
}

class _EditHeightAndWeightPageState extends State<EditHeightAndWeightPage> {
  Profile _profile = Profile();
  
  ScrollController _weightController;
  ScrollController _heightController;
  String _bloodTypeValue;
  final metersController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
    kilogramController.addListener(() {
      _profile.weight = double.parse(kilogramController.text);
    });
    metersController.addListener(() {
      _profile.height = double.parse(metersController.text);
    });
  }
  @override
  void dispose() {
    metersController.dispose();
    kilogramController.dispose();
    super.dispose();
  }
  void _handleHeightScaleChanged(int scalePoints) {
    int inchOffest = scalePoints ~/ 20;
    double meters = inchOffest / 12;
    double roundOffMeters = double.parse((meters).toStringAsFixed(2));
    metersController.text = roundOffMeters.toString();
  }
  void _handleWeightScaleChanged(int scalePoints) {
    int gram = scalePoints ~/ 20;
    double kg = ((gram * 100) / 1000);
    kilogramController.text = kg.toString();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          Profile _currentProfile = snapshots.data;

          return ContentContainer(
            width: MediaQuery.of(context).size.width,
            child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  buildHeightScale(context, _heightController, _handleHeightScaleChanged),
                  SizedBox(height: 12),
                  buildHeightWeightField(context, metersController, _currentProfile.height.toString(), 'm'),
                  SizedBox(height: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildWeightScale(context, _weightController, _handleWeightScaleChanged),
                      SizedBox(height:12),
                      buildHeightWeightField(context, kilogramController, _currentProfile.weight.toString(), 'kg') ,
                      SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
          );
        }
        return Container();
      },
    );
  }
}

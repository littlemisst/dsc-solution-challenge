import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/itemBuilder.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/bloodPressureLog/bpListTile.dart';
import 'package:me_daily/updated-pages/summaryPage/bloodPressureLog/bpViewModel.dart';
import 'package:provider/provider.dart';


class BloodPressurePage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final _user = Provider.of<User>(context);
    final database = FirestoreService(uid: _user.uid);
    return Provider<BloodPressureViewModel>(
      create: (_) => BloodPressureViewModel(database: database),
      child: BloodPressurePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('Blood Pressure Log History'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: _buildContents(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final vm = Provider.of<BloodPressureViewModel>(context);
    return StreamBuilder<List<BloodPressureListTileModel>>(
      stream: vm.bloodPressureTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<BloodPressureListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => BloodPressureListTile(model: model),
        );
      },
    );
  }
}

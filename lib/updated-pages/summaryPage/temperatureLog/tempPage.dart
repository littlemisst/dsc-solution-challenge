import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/itemBuilder.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/temperatureLog/tempListTile.dart';
import 'package:me_daily/updated-pages/summaryPage/temperatureLog/tempViewModel.dart';

import 'package:provider/provider.dart';


class TemperaturePage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final _user = Provider.of<User>(context);
    final database = FirestoreService(uid: _user.uid);
    return Provider<TemperatureViewModel>(
      create: (_) => TemperatureViewModel(database: database),
      child: TemperaturePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('Temperature Log History'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: _buildContents(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final vm = Provider.of<TemperatureViewModel>(context);
    return StreamBuilder<List<TemperatureListTileModel>>(
      stream: vm.temperatureTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<TemperatureListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => TemperatureListTile(model: model),
        );
      },
    );
  }
}

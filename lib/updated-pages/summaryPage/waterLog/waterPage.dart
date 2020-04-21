import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/itemBuilder.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/waterLog/waterListTile.dart';
import 'package:me_daily/updated-pages/summaryPage/waterLog/waterViewModel.dart';
import 'package:provider/provider.dart';


class WaterPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final _user = Provider.of<User>(context);
    final database = FirestoreService(uid: _user.uid);
    return Provider<WaterViewModel>(
      create: (_) => WaterViewModel(database: database),
      child: WaterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('Water Log History'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: _buildContents(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final vm = Provider.of<WaterViewModel>(context);
    return StreamBuilder<List<WaterListTileModel>>(
      stream: vm.waterTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<WaterListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => WaterListTile(model: model),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/itemBuilder.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/menstrual/menstrual_list_tile.dart';
import 'package:me_daily/updated-pages/menstrual/menstrual_view_model.dart';
import 'package:provider/provider.dart';


class MenstrualPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final _user = Provider.of<User>(context);
    final database = FirestoreService(uid: _user.uid);
    return Provider<MenstrualViewModel>(
      create: (_) => MenstrualViewModel(database: database),
      child: MenstrualPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('Menstrual Period Log History'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: _buildContents(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final vm = Provider.of<MenstrualViewModel>(context);
    return StreamBuilder<List<MenstrualListTileModel>>(
      stream: vm.menstrualTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<MenstrualListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => MenstrualListTile(model: model),
        );
      },
    );
  }
}

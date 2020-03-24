import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:me_daily/model/feeling.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/pages/healthChart.dart';
import 'package:me_daily/pages/tasksDetails.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/sendDetails/sendDetailsPage.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Widget _buildTiles(context, child) {
    return Material(
      elevation: 5,
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: child,
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Health>>.value(
      value: FirestoreService(uid: user.uid).feelings,
      child: Container(
        padding: EdgeInsets.all(10),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          staggeredTiles: [
            StaggeredTile.count(4, 3),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(4, 1),
          ],
          children: <Widget>[
            _buildTiles(context, HealthChart()),
            _buildTiles(context, TasksDetails()),
            _buildTiles(context, Text('Logs')),
            _buildTiles(context, Text('Achievements')),
          ],
        ),
      ),
    );
  }
}

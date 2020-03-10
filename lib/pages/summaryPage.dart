import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:me_daily/pages/healthChart.dart';
import 'package:me_daily/pages/sendDetailsPage.dart';

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

  Widget _buildShareButton() {
    return RaisedButton(
        color: Colors.pink[100],
        child: Text('Share your details'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SendDetailsPage()));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          StaggeredTile.count(4, 1)
        ],
        children: <Widget>[
          _buildTiles(context, HealthChart()),
          _buildTiles(context, Text('Streak')),
          _buildTiles(context, Text('Uncompleted Tasks')),
          _buildTiles(context, Text('Achievements')),
          _buildShareButton()
        ],
      ),
    );
  }
}

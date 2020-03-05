import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/api/view_task_api.dart';
import 'package:me_daily/pages/addTask.dart';

class ViewTasks extends StatefulWidget {
  @override
  _ViewTasksState createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTask()));
              },
            )
          ],
        ),
        body: Center(
          child: StreamBuilder(
          stream: fetchTasks(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text("Something went wrong");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default: 
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                    buildTaskCard(context, snapshot.data.documents[index])
                );
            }
          },
        )
      )
    );
  }

  Widget buildTaskCard(BuildContext context, DocumentSnapshot task) {
    return Container(
        child: Card(
            child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Row(children: <Widget>[
              Text(
                task['specificTask'],
                style: TextStyle(fontSize: 30),
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Row(children: <Widget>[
              // Text("${task['taskStarted'].toString()} - ${task['taskEnded'].toString()}"),
              Text(task['taskType']),
              Spacer(),
            ]),
          ),
        ],
      ),
    )));
  }
}

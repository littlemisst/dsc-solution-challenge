import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  String _taskType = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _tasksGrid(),
            ],
          ),
        ));
  }

  void _eatView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20)),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Bread'),
                        leading: Radio(
                          value: 'bread',
                          groupValue: _description,
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Cereal'),
                        leading: Radio(
                          value: 'cereal',
                          groupValue: _description,
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                        ),
                      )
                    ],
                  )));
        });
    }

    void _drinkView() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Water'),
                  leading: Radio(
                    value: 'water',
                    groupValue: _description,
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Coffee'),
                  leading: Radio(
                    value: 'coffee',
                    groupValue: _description,
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                )
              ],
            )
          )
        );
      });
    }
  

  _tasksGrid() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        children: <Widget>[
          _gridItem(new AssetImage("images/dish.png"), 'Eat'),
          _gridItem(new AssetImage("images/wine_bottle.png"), 'Drink'),
          _gridItem(new AssetImage("images/barbell.png"), 'Exercise'),
          _gridItem(new AssetImage("images/medical_tablet.png"), 'Medicine'),
          _gridItem(
              new AssetImage("images/medical_history.png"), 'Appointments'),
          _gridItem(new AssetImage("images/add.png"), 'More')
        ],
      ),
    );
  }

  _gridItem(icon, text) {
    return Column(
      children: <Widget>[
        FlatButton(
            padding: EdgeInsets.all(10),
            child: ImageIcon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            color: Colors.pink[100],
            shape: CircleBorder(side: BorderSide.none),
            onPressed: () {
              _taskType = text;
              switch (_taskType) {
                case 'Eat' :
                  _eatView();
                  break;
                case 'Drink':
                  _drinkView();
                  break;
              }
              print(_taskType);
  
            }),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
          ),
        )
      ],
    );
  }
}

// child: Container(
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//       color: Colors.pink[50]
//     ),
//   ),
// );
// }

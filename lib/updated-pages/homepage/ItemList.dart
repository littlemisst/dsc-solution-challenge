import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, this.icon, this.text, this.onTap}) : super(key:key);
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container( 
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(text, style: TextStyle(color: Colors.grey)),
        onTap: onTap,
      )
    ); 
  }
}
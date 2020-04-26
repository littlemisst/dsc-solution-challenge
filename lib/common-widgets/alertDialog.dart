
import 'package:flutter/material.dart';

enum DialogAction { yes, cancel }


class Dialogs {
  static Future<DialogAction> showDialogBox(
    BuildContext context, String title) async {
      final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius : BorderRadius.circular(10)
            ),
            title: Text(title),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(
                  DialogAction.cancel
                ),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(
                  DialogAction.yes
                ),
                child: Text('Yes'),
              )
            ],
          );
        }
      );
      return (action != null) ? action : DialogAction.cancel;
    }
}
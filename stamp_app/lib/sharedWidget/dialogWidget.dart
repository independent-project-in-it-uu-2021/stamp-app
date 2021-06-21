import 'package:flutter/material.dart';

//Enum aka constant value
enum DialogAction { option1, option2, abort }

//Dialog class that can be reuse
class Dialogs {
  static Future<DialogAction> dialogAction(BuildContext context, String title,
      String option1Text, String option2Text) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title),
          children: [
            SimpleDialogOption(
              child: Text(option1Text),
              onPressed: () => Navigator.of(context).pop(DialogAction.option1),
            ),
            SimpleDialogOption(
              child: Text(option2Text),
              onPressed: () {
                Navigator.of(context).pop(DialogAction.option2);
              },
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}

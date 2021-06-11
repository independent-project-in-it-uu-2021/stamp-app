import 'package:flutter/material.dart';

//Enum aka constant value
enum DialogAction { gallery, camera, abort }

//Dialog class that can be reuse
class Dialogs {
  static Future<DialogAction> dialogAction(
      BuildContext context, String title) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title),
          children: [
            SimpleDialogOption(
              child: Text('Från mobil'),
              onPressed: () => Navigator.of(context).pop(DialogAction.gallery),
            ),
            SimpleDialogOption(
              child: Text('Ta bild'),
              onPressed: () {
                Navigator.of(context).pop(DialogAction.camera);
              },
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}

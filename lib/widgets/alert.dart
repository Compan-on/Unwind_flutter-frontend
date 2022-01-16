import "package:flutter/material.dart";
import 'package:intl/intl.dart';

Future returnAlertValue(BuildContext context, String msg1, String msg2) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(msg1),
          content: Text(msg2),
          actions: [
            FlatButton(
                textColor: Colors.green,
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text("Confirm")),
            FlatButton(
                textColor: Colors.red,
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text("Cancel")),
          ],
        );
      });
}

Future showMessageAlert(BuildContext context, String msg1) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(msg1),
          actions: [
            FlatButton(
                textColor: Colors.green,
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text("OK")),
          ],
        );
      });
}

Future showFeedAlert(BuildContext context, Map post) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post["postContent"],
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat.yMMMMd()
                        .format(DateTime.parse(post["created_at"]))
                        .toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

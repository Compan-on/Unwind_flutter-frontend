import "package:flutter/material.dart";

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
                  Navigator.of(context).pop(true);
                },
                child: const Text("Confirm")),
            FlatButton(
                textColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop(false);
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
                  Navigator.of(context).pop(true);
                },
                child: const Text("OK")),
          ],
        );
      });
}

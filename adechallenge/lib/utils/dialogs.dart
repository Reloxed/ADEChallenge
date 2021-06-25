import 'package:flutter/material.dart';

/*
Dialog used on the register screen to confirm that the account has been created, and redirect to the login page.
 */
dynamic acceptDialogRegister(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext builder) {
        return AlertDialog(
          title: new IconTheme(
            data: new IconThemeData(
              color: Colors.green,
            ),
            child: Icon(Icons.thumb_up),
          ),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Center(child: Text(message))])),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  primary: Theme.of(context).primaryColor,
                  elevation: 3
              ),
              onPressed: () {
                // We do the same twice, once to close the dialog and another one to go back to the login page.
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("ENTENDIDO"),
            )
          ],
        );
      });
}

/*
Generic dialog for showing possible errors
 */
dynamic errorDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext builder) {
        return AlertDialog(
          title: new IconTheme(
            data: new IconThemeData(
              color: Colors.red,
            ),
            child: Icon(Icons.error),
          ),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Center(child: Text(message))])),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  primary: Theme.of(context).primaryColor,
                  elevation: 3
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("ENTENDIDO"),
            )
          ],
        );
      });
}
import 'package:flutter/material.dart';
import 'package:new_project_driving/fonts/google_poppins_widget.dart';

mobileandTabAlert(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: GooglePoppinsWidgets(text: 'Message', fontsize: 15),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GooglePoppinsWidgets(
                  text:
                      'Please login to the Desktop Site for Better Experience..',
                  fontsize: 15),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

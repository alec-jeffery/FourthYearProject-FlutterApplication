import 'package:flutter/material.dart';
import 'package:http/http.dart';

///*
/// Creates a modal based off a Response.body and a given String popupTitle
/// that can be closed out of.
Widget httpRequestPopup(
    BuildContext context, String popupTitle, String bodyText) {
  return AlertDialog(
    title: Text(popupTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(bodyText),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

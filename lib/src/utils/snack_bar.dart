import 'package:flutter/material.dart';

//snack bar
showSnackBar(String data, BuildContext context, [Function? param]) {
  final snackBar = SnackBar(
    content: Text(data),
    duration: Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

import 'package:flutter_base_app/src/res/app_size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//ProgressDialog
showProgressDialog(BuildContext context, [String message]) {
  SizeConfig().init(context);
  Widget _drawerWidget = Container(
    child: SafeArea(
      child: SizedBox.expand(
        child: Center(
          child: Container(
            height: 120.0,
            width: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoActivityIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message == null ? 'Please Wait' : message,
                  style: TextStyle(color: Colors.black54, fontSize: 14.0, decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    ),
    color: Colors.transparent,
  );

  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (_, __, ___) {
      return _drawerWidget;
    },
  );
}

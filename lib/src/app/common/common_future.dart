import 'package:flutter/material.dart';

import 'text_widget.dart';

class CommonFuture<T> extends StatelessWidget {
  // final Widget successWidget;
  final Widget Function(T data) data;
  final Future<T> future;
  final T initialData;
  const CommonFuture({this.future, this.initialData, this.data});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return TextWidget(text: 'Error Occured');
          }
          return data(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

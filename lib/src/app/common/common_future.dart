import 'package:flutter/material.dart';

import 'text_widget.dart';

class CommonFuture<T> extends StatelessWidget {
  final Widget Function(T data) data;
  final Future<T> future;
  final T? initialData;
  final bool showLoadingWidget;
  const CommonFuture({
    Key? key,
    required this.data,
    required this.future,
    this.initialData,
    required this.showLoadingWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const TextWidget(text: 'Error Occured');
          }
          return data(snapshot.data!);
        } else {
          return showLoadingWidget
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : data(initialData!);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool insideSafeArea;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.insideSafeArea = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: body,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomNavigationBar: bottomNavigationBar,
    );
    return insideSafeArea
        ? SafeArea(
            child: scaffold,
          )
        : scaffold;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: DefaultTextStyle(
        style: TextStyle(fontSize: 64, color: Colors.white),
        child: SidebarView(
          iconView: Icon(
            CupertinoIcons.settings,
            color: Colors.white,
          ),
          mainView: MainView(),
          sideView: SettingsView(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class SidebarView extends StatelessWidget {
  final Widget iconView;
  final Widget mainView;
  final Widget sideView;
  final double sideWidthFactor = 0.3;

  SidebarView({
    super.key,
    required this.iconView,
    required this.mainView,
    required this.sideView,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: mainView,
            );
          })),
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth * sideWidthFactor,
            child: Stack(children: [
              sideView,
              Positioned(
                child: iconView,
                right: 8.0,
                top: 8.0,
              )
            ]),
          )
        ],
      );
    });
  }
}

class MainView extends StatelessWidget {
  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange, child: Center(child: Text("MainView")));
  }
}

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: Center(child: Text("SettingsView")));
  }
}

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

class SidebarView extends StatefulWidget {
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
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  double sideOpenFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            right: 0.0,
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth * widget.sideWidthFactor,
              child: Stack(children: [
                widget.sideView,
                Positioned(
                  child: widget.iconView,
                  right: 8.0,
                  top: 8.0,
                )
              ]),
            ),
          ),
          Positioned(child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth *
                  (1 - widget.sideWidthFactor * sideOpenFactor),
              child: widget.mainView,
            );
          })),
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

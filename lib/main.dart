import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  const double fontSize = 64;

  runApp(
    const MaterialApp(
      home: DefaultTextStyle(
        style: TextStyle(fontSize: fontSize, color: Colors.white),
        child: SidebarWidget(
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

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange, child: const Center(child: Text("MainView")));
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text("SettingsView")));
  }
}

class SidebarWidget extends StatefulWidget {
  final Widget iconView;
  final Widget mainView;
  final Widget sideView;

  final double sideViewWidthRatio = 0.3;
  final double defaultPaddingSize = 8.0;
  final int sideViewOpenAnimationDuration = 500; // ms

  const SidebarWidget({
    super.key,
    required this.iconView,
    required this.mainView,
    required this.sideView,
  });

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  double sideViewOpenProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            right: 0.0,
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth * widget.sideViewWidthRatio,
              child: widget.sideView,
            ),
          ),
          Positioned(child: LayoutBuilder(builder: (context, constraints) {
            return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: sideViewOpenProgress),
                duration: Duration(
                    milliseconds: widget.sideViewOpenAnimationDuration),
                curve: Curves.easeInOutSine,
                builder: (BuildContext context, double tweenSideOpenFactor,
                    Widget? child) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth *
                        (1 - widget.sideViewWidthRatio * tweenSideOpenFactor),
                    child: widget.mainView,
                  );
                });
          })),
          Positioned(
            right: widget.defaultPaddingSize,
            top: widget.defaultPaddingSize,
            child: GestureDetector(
                onTap: () {
                  if (sideViewOpenProgress == 0.0) {
                    setState(() {
                      sideViewOpenProgress = 1.0;
                    });
                  } else if (sideViewOpenProgress == 1.0) {
                    setState(() {
                      sideViewOpenProgress = 0.0;
                    });
                  } else {
                    debugPrint("do nothing");
                  }
                },
                child: widget.iconView),
          )
        ],
      );
    });
  }
}

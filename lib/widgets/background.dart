import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:flutter/material.dart';

import 'cloud_widget.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        fit: .expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/moon.png",
              fit: .fitWidth,
              width: 120,
            ),
          ),

          Positioned(bottom: 0, child: CloudWidget()),

          if (child != null) ...{Positioned.fill(child: child!)},
        ],
      ),
    );
  }
}

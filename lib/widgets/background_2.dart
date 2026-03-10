import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:flutter/material.dart';

import 'cloud_widget.dart';

class Background2 extends StatelessWidget {
  const Background2({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purple,
        body: Stack(
          fit: .expand,
          children: [
            Positioned(
              top: 0,
              child: Transform.flip(flipY: true, child: CloudWidget()),
            ),
            Positioned(bottom: 0, child: CloudWidget()),

            if (child != null) ...{Positioned.fill(child: child!,)},
          ],
        ),
      ),
    );
  }
}

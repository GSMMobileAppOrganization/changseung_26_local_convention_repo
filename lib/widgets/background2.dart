import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:flutter/material.dart';

import 'cloud_widget.dart';

class Background2 extends StatelessWidget {
  const Background2({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: purple,
        body: Stack(
          fit: .expand,
          children: [
            Positioned(bottom: 0, child: CloudWidget()),
            Positioned(
              top: 0,
              child: Transform.flip(flipY: true, child: CloudWidget()),
            ),
      
            if (child != null) ...{Positioned.fill(child: child!)},
          ],
        ),
      ),
    );
  }
}

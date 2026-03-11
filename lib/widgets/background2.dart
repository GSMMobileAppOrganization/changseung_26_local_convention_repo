import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
            Positioned.fill(
              bottom: 0,
              child: cloud(),
            ),
            Positioned.fill(
              top: 0,
              child: Transform.flip(flipY: true, child: cloud()),
            ),
            if (child != null) ...{Positioned.fill(child: child!)},
          ],
        ),
      ),
    );
  }
}

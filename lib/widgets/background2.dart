import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  const Background2({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: background(
          child: Stack(
            children: [
              Transform.flip(flipY: true, child: cloud()),
              cloud(),
              if (child != null) Positioned.fill(child: Center(child: child!)),
            ],
          ),
        ),
      ),
    );
  }
}

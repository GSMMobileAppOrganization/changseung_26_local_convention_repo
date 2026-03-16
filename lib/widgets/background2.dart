import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  const Background2({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: background(
          child: Stack(
            children: [
              cloud(),
              Transform.flip(flipY: true, child: cloud()),
              Positioned.fill(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

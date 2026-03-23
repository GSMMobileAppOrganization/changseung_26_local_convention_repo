import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background1 extends StatelessWidget {
  const Background1({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: background(
          child: Stack(
            children: [
              cloud(),

              moon(140),

              if (child != null) Positioned.fill(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class Background2 extends StatelessWidget {
  const Background2({super.key, required this.child, this.down = false});

  final Widget child;
  final bool down;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: background(
          child: Stack(
            children: [
              Positioned.fill(
                top: down ? -36 : 0,
                child: Transform.flip(flipY: true, child: cloud()),
              ),
              Positioned.fill(bottom: down ? -36 : 0, child: cloud()),
              Positioned.fill(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

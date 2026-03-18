import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
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
              moon(120),
              cloud(),
              if (child != null) Positioned.fill(child: Center(child: child!)),
            ],
          ),
        ),
      ),
    );
  }
}

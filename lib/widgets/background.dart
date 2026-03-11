import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purple,
      body: Stack(
        children: [
          moon(100),
          cloud(),
          if (child != null) ...{Positioned.fill(child: child!)},
        ],
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background1 extends StatelessWidget {
  const Background1({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purpleAccent, purple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        child: Stack(children: [moon(160), cloud(), if (child != null) child!]),
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  const Background2({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [purpleAccent, purple],
              begin: .topLeft,
              end: .bottomRight,
            ),
          ),
          child: Stack(
            fit: .expand,
            children: [
              Positioned.fill(
                top: 0,
                child: Transform.flip(flipY: true, child: cloud()),
              ),
      
              Positioned.fill(bottom: 0, child: cloud()),
      
              ?child,
            ],
          ),
        ),
      ),
    );
  }
}

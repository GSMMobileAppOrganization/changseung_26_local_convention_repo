import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background1 extends StatelessWidget {
  const Background1({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: background(
          child: Stack(
            children: [
              Padding(padding: .only(top: 12), child: moon(140)),
              cloud(),

              Positioned.fill(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

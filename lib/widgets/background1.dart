import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Background1 extends StatelessWidget {
  const Background1({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: background(Stack(children: [moon(160), cloud(), ?child])),
    );
  }
}

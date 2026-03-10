import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/widgets/cloud_widget.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.child});

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
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox.square(
                dimension: 160,
                child: Image.asset("assets/images/moon.png"),
              ),
            ),
            Positioned(bottom: 0, child: CloudWidget()),
      
            if (child != null) ...{child!},
          ],
        ),
      ),
    );
  }
}

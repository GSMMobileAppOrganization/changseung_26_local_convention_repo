import 'package:flutter/material.dart';

class LogoWidget2 extends StatelessWidget {
  const LogoWidget2({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        SizedBox(
          height: 42,
          child: ClipRect(
            child: Image.asset(
              "assets/images/graphic.png",
              fit: .fitWidth,
              width: 62,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 18,
          ),
          textAlign: .center,
        ),
      ],
    );
  }
}

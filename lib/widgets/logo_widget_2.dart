import 'package:flutter/material.dart';

class LogoWidget2 extends StatelessWidget {
  const LogoWidget2({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: .topCenter,
              child: Image.asset(
                "assets/images/graphic.png",
                fit: .fitWidth,
                width: 64,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: .bottomCenter,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

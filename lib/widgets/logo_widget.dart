import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: text != null ? 150 : 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: .topCenter,
              child: Image.asset(
                "assets/images/Daily Tarot.png",
                fit: .fitWidth,
                width: 200,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: text != null ? .center : .bottomCenter,
              child: Image.asset(
                "assets/images/graphic.png",
                fit: .fitWidth,
                width: 64,
              ),
            ),
          ),

          if (text != null) ...{
            Positioned.fill(
              child: Align(
                alignment: Alignment(0, .5),
                child: Text(
                  text!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}

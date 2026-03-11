import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Image.asset(
          width: 200,
          fit: .fitWidth,
          "assets/images/Daily Tarot.png",
        ),
        SizedBox(
          height: 24,
          child: ClipRect(
            clipBehavior: .hardEdge,
            child: Image.asset(
              width: 62,
              fit: .fitWidth,
              "assets/images/graphic.png",
            ),
          ),
        ),

        if (title != null)
          Text(
            title!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontSize: 18,
            ),
          ),
      ],
    );
  }
}

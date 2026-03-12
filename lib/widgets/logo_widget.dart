import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.title, this.ver2 = false});

  final String? title;
  final bool ver2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        if(!ver2)

        Image.asset(
          "assets/images/Daily Tarot.png",
          fit: .fitWidth,
          width: 200,
        ),
        SizedBox(
          height: 32,
          child: ClipRect(
            child: Image.asset(
              "assets/images/graphic.png",
              fit: .fitWidth,
              width: 62,
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
            textAlign: .center,
          ),
      ],
    );
  }
}

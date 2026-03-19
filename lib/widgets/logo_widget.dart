import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.title, this.ver2 = false});

  final String? title;

  final bool ver2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!ver2)
          Image.asset(
            "assets/images/Daily Tarot.png",
            width: 200,
            fit: .fitWidth,
          ),
        SizedBox(
          height: 42,
          child: ClipRect(
            clipBehavior: .hardEdge,
            child: Image.asset(
              "assets/images/graphic.png",
              width: 64,
              fit: .fitWidth,
            ),
          ),
        ),

        if (title != null) title18W(title!, align: .center, weight: .w800),
      ],
    );
  }
}

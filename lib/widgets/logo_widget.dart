import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.title, this.ver2 = false});

  final String? title;
  final bool ver2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (ver2 ? 100 : 160) - (title == null ? 60 : 0),
      child: Stack(
        children: [
          if (!ver2) ...{
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
          },
          Positioned.fill(
            child: Align(
              alignment: ver2
                  ? .topCenter
                  : title == null
                  ? .bottomCenter
                  : .center,
              child: Image.asset(
                "assets/images/graphic.png",
                fit: .fitWidth,
                width: 64,
              ),
            ),
          ),
          if (title != null) ...{
            Positioned.fill(
              child: Align(
                alignment: Alignment(0, 0.6),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: .w800,
                    fontSize: 18,
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

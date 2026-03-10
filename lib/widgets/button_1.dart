import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/widgets/moon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    required this.tap,
    required this.text,
    this.ver2 = false,
  });

  final VoidCallback tap;
  final String text;
  final bool ver2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: .symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          boxShadow: [
            BoxShadow(
              color: gradY.withAlpha(100),
              blurRadius: 16,
              offset: .new(3, 4),
              spreadRadius: 1,
            ),
          ],
          gradient: RadialGradient(
            center: .topLeft,
            radius: ver2 ? 3.6 : 1.6,
            colors: [gradY, purpleAccent],
          ),
        ),
        child: Row(
          mainAxisSize: .min,
          children: <Widget>[
            if (ver2) ...{MoonWidget(size: 32), SizedBox(width: 8)},

            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),

            if (!ver2) ...{
              SizedBox.square(
                dimension: 24,
                child: Transform.flip(
                  flipX: true,
                  child: SvgPicture.asset("assets/icons/arrow_back.svg"),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}

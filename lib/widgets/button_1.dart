import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/widgets/moon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    required this.tap,
    this.ver2 = false,
    required this.title,
    this.hasIcon = true,
  });

  final VoidCallback tap;
  final String title;

  final bool ver2;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(28),
          gradient: RadialGradient(
            colors: [gradY, purpleAccent],
            radius: ver2 ? 4 : 2,
            center: .topLeft,
          ),
        ),
        padding: .symmetric(horizontal: 32, vertical: 14),
        child: hasIcon
            ? Row(
                mainAxisSize: .min,
                children: [
                  if (ver2) ...{MoonWidget(size: 26)},

                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: 18,
                    ),
                  ),

                  if (!ver2) ...{
                    Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                        fit: .fitWidth,
                        width: 24,
                      ),
                    ),
                  },
                ],
              )
            : Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button2 extends StatelessWidget {
  const Button2({
    super.key,
    required this.tap,
    required this.text,
    this.reverse = false,
    this.hasIcon = true,
  });

  final VoidCallback tap;
  final String text;
  final bool reverse;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        elevation: .all(2),
        surfaceTintColor: .all(Colors.white),
        padding: .all(
          .only(
            right: reverse ? 32 : 22,
            left: !reverse ? 32 : 22,
            top: 12,
            bottom: 12,
          ),
        ),
      ),

      onPressed: tap,
      label: reverse ? _text() : _icon(),
      icon: !reverse ? _text() : _icon(),
    );
  }

  Widget _text() => Text(
    text,
    style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 18),
  );

  Widget _icon() => hasIcon
      ? Transform.flip(
          flipX: !reverse,
          child: SvgPicture.asset(
            "assets/icons/arrow_back.svg",
            fit: .fitWidth,
            width: 18,
          ),
        )
      : SizedBox.shrink();
}

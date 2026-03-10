import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        surfaceTintColor: .all(Colors.white),
        elevation: .all(2),
        padding: .all(
          hasIcon
              ? .only(
                  right: reverse ? 16 : 24,
                  top: 16,
                  bottom: 16,
                  left: !reverse ? 16 : 24,
                )
              : .symmetric(vertical: 16, horizontal: 36),
        ),
      ),
      onPressed: tap,
      label: !reverse ? _text() : _icon(),
      icon: hasIcon
          ? reverse
                ? _text()
                : _icon()
          : null,
    );
  }

  Widget _text() => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: .bold,
      fontFamily: font2,
    ),
  );

  Widget _icon() => SizedBox.square(
    dimension: 24,
    child: Transform.flip(
      flipX: reverse,
      child: SvgPicture.asset("assets/icons/arrow_back.svg"),
    ),
  );
}

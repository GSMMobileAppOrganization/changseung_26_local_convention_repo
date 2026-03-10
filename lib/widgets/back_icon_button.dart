import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: .all(8),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            "assets/icons/arrow_back.svg",
            fit: .fitWidth,
            width: 28,
          ),
        ),
      ),
    );
  }
}

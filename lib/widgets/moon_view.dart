import 'package:flutter/material.dart';

import '../app_controller.dart';
import '../main.dart';
import '../screens/moon_charge_screen.dart';
import 'moon_widget.dart';

class MoonView extends StatelessWidget {
  const MoonView({super.key, this.isBig = false});

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: 12),
      child: Row(
        mainAxisSize: .min,
        children: [
          MoonWidget(size: isBig ? 36 :24),
          Text(
            "${appController.moonCount}",
            style: TextStyle(
              fontFamily: font2,
              color: Colors.white,
              fontSize: isBig ? 18 : null,
              fontWeight: .bold,
            ),
          ),
        ],
      ),
    );
  }
}

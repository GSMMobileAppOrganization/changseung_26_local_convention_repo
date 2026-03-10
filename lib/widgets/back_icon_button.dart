import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: .all(12),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: IconWidget(path: "assets/icons/arrow_back.svg", size: 28),
        ),
      ),
    );
  }
}

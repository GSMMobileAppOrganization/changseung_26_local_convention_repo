import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/background1.dart';
import 'package:daily_tarot_poc_app_6/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.child,
    required this.prevPage,
    required this.progress,
    this.isForgot = false,
  });

  final String title;
  final Widget child;
  final Widget? prevPage;
  final int? progress;
  final bool isForgot;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Column(
        children: [
          SizedBox(height: 120),

          LogoWidget(title: title),

          child,

          Spacer(),

          if (prevPage != null)
            Row(
              spacing: 12,
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 100,
                  child: button2(
                    "이전",
                    () => appController.back(context, prevPage!),
                  ),
                ),
                if (isForgot)
                  SizedBox(
                    width: 180,
                    child: button2("잘 모르겠어요", () {
                      appController.time = null;
                      appController.move(context, CheckScreen());
                    }, isBack: false),
                  ),
              ],
            ),

          SizedBox(height: 42),

          if (progress != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: .only(left: index < progress! ? 2 : 0),
                    child: Container(
                      height: 8,
                      color: index < progress!
                          ? Colors.white
                          : Colors.white.withAlpha(100),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

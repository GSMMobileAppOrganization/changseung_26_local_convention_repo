import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/background1.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.child,
    required this.progress,
    required this.prevPage,
    this.isForgot = false,
  });

  final String title;
  final Widget child;
  final int? progress;
  final Widget? prevPage;
  final bool isForgot;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Column(
        children: [
          SizedBox(height: 140),

          LogoWidget(title: title),

          child,

          Spacer(),

          if (prevPage != null)
            Row(
              mainAxisAlignment: .center,
              spacing: 18,
              children: [
                SizedBox(
                  width: 110,
                  child: button2(
                    "이전",
                    () => appController.back(context, prevPage!),
                    isBack: true,
                  ),
                ),

                if (isForgot)
                  SizedBox(
                    width: 200,
                    child: button2("잘 모르겠어요", () {
                      appController.time = null;
                      appController.move(context, CheckScreen());
                    }, isBack: false),
                  ),
              ],
            ),

          SizedBox(height: 48),

          if (prevPage != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: .only(left: progress! > index ? 1 : 0),
                    child: Container(
                      height: 8,
                      color: progress! > index
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

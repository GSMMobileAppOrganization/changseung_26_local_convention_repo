import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/background1.dart';
import 'package:daily_tarot_poc_app_8/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
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
                  width: 120,
                  child: button2(
                    "이전",
                    () => appController.back(context, prevPage!),
                  ),
                ),
                if (isForgot)
                  SizedBox(
                    width: 190,
                    child: button2(isBack: false, "잘 모르겠어요", () {
                      appController.time = null;
                      appController.go(context, CheckScreen());
                    }),
                  ),
              ],
            ),

          SizedBox(height: 48),

          if (progress != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: progress! > index ? 2 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: progress! > index
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        borderRadius: progress! > index ? .circular(8) : null,
                      ),
                      height: 8,
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

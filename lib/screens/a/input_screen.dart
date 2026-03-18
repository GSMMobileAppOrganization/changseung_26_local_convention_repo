import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/background1.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.child,
    required this.prevPage,
    required this.progress,
    this.isForgot = false,
    required this.title,
  });

  final Widget child;
  final Widget? prevPage;
  final int? progress;
  final bool isForgot;
  final String title;

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
              spacing: 12,
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 100,
                  child: button2(
                    "이전",
                    () => appController.go(context, prevPage!),
                  ),
                ),

                if (isForgot)
                  SizedBox(
                    width: 160,
                    child: button2(isBack: false, "잘 모르겠어요", () {
                      appController.time = null;
                      appController.go(context, CheckScreen());
                    }),
                  ),
              ],
            ),

          SizedBox(height: 36),

          if (progress != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: index < progress! ? 1 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: index < progress! ? .circular(8) : null,
                        color: index < progress!
                            ? Colors.white
                            : Colors.white54,
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

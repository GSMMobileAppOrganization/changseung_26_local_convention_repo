import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/check_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.child,
    required this.prevPage,
    required this.progress,
  });

  final String title;
  final Widget child;
  final Widget? prevPage;
  final int? progress;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Column(
        children: [
          SizedBox(height: 130),

          LogoWidget(title: title),

          child,

          Spacer(),

          if (prevPage != null)
            Row(
              mainAxisAlignment: .center,
              spacing: 12,
              children: [
                SizedBox(
                  width: 100,
                  child: button2(
                    "이전",
                    () => appController.back(context, prevPage!),
                  ),
                ),

                if (progress == 5)
                  SizedBox(
                    width: 170,
                    child: button2("잘 모르겠어요", isBack: false, () {
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
        ],
      ),
    );
  }
}

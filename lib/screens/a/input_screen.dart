import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/background1.dart';
import 'package:daily_tarot_poc_app_10/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.prevPage,
    required this.child,
    required this.count,
    this.isForgot = false,
  });

  final String title;
  final Widget? prevPage;
  final Widget child;
  final int? count;
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
                    child: button2(isBack: false, "잘 모르겠어요", () {
                      appController.time = null;
                      appController.back(context, CheckScreen());
                    }),
                  ),
              ],
            ),

          SizedBox(height: 48),

          if (count != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: .only(left: index < count! ? 1 : 0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: index < count! ? Colors.white : Colors.white54,
                        borderRadius: index < count! ? .circular(8) : null,
                      ),
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

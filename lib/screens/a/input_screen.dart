import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background1.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.pro,
    required this.prevPage,
    required this.child,
    this.isForgot = false,
  });

  final String title;
  final int? pro;
  final Widget? prevPage;
  final Widget child;
  final bool isForgot;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Column(
        children: [
          SizedBox(height: 140),

          LogoWidget(title: title),

          Center(child: child),

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
                    () => appController.go(context, prevPage!),
                  ),
                ),
                if (isForgot)
                  SizedBox(
                    width: 180,
                    child: button2(isBack: false, "잘 모르겠어요", () {
                      appController.time = null;
                      appController.go(context, CheckScreen());
                    }),
                  ),
              ],
            ),

          SizedBox(height: 48),

          if (pro != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: index < pro! ? 1 : 0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: index < pro!
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        borderRadius: .circular(index < pro! ? 8 : 0),
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

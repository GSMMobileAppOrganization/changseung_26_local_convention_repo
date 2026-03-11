import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background1.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.progress,
    required this.child,
    required this.prevPage,
    this.isForgot = false,
    this.hasIcon = true,
  });

  final String title;
  final int progress;
  final Widget child;
  final Widget prevPage;
  final bool isForgot;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 128),

            LogoWidget(title: title),

            child,

            Spacer(),

            if (hasIcon)
              Row(
                spacing: 18,
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    width: 120,
                    child: button2(
                      "이전",
                      () => appController.back(context, prevPage),
                    ),
                  ),

                  if (isForgot)
                    SizedBox(
                      width: 180,
                      child: button2(
                        isBack: false,
                        "잘 모르겠어요",
                        () => appController.move(context, CheckScreen()),
                      ),
                    ),
                ],
              ),

            SizedBox(height: 48),

            if (hasIcon)
              Row(
                children: List.generate(
                  5,
                  (index) => Flexible(
                    child: Padding(
                      padding: .only(left: progress > index ? 1 : 0),
                      child: Container(
                        height: 8,
                        color: progress > index
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

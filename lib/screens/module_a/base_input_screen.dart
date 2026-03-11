import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/check_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BaseInputScreen extends StatelessWidget {
  const BaseInputScreen({
    super.key,
    required this.title,
    required this.child,
    required this.progress,
    this.isForgot = false,
    required this.prevPage,
  });

  final String title;
  final Widget child;
  final int? progress;
  final bool isForgot;
  final Widget? prevPage;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          SizedBox(height: 120),

          LogoWidget(title: title),

          SizedBox(height: 42),

          child,

          Spacer(flex: 3),

          if (prevPage != null) ...{
            Row(
              spacing: 24,
              mainAxisAlignment: .center,
              children: [
                button2(
                  "이전",
                  () => appController.moveReplace(context, prevPage!),
                  isBack: true,
                ),
                if (isForgot) ...{
                  SizedBox(
                    width: 190,
                    child: button2("잘 모르겠어요", () {
                      appController.birthTime = null;
                      appController.move(context, CheckScreen());
                    }, isBack: false),
                  ),
                },
              ],
            ),
          },

          SizedBox(height: 64),

          if (progress != null) ...{
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: .only(left: progress! > index ? 1 : 0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: progress! > index
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        borderRadius: .circular(progress! > index ? 5 : 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}

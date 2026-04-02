import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/background.dart';
import 'package:daily_tarot_poc_app_11/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({
    super.key,
    required this.title,
    required this.child,
    required this.prevPage,
    required this.count,
    this.isForgot = false,
  });

  final String title;
  final Widget child;
  final Widget? prevPage;
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
              mainAxisAlignment: .center,
              spacing: 24,
              children: [
                SizedBox(
                  width: 100,
                  child: button2("이전", () {
                    appController.back(context, prevPage!);
                  }),
                ),

                if (isForgot)
                  SizedBox(
                    width: 180,
                    child: button2(isBack: false, "잘 모르겠어요", () {
                      appController.saveTime(null);
                      appController.go(context, CheckScreen());
                    }),
                  ),
              ],
            ),

          SizedBox(height: 36),

          if (count != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: index < count! ? 1 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: index < count! ? Colors.white : Colors.white54,
                        borderRadius: .circular(index < count! ? 8 : 0),
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

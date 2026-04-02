import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/screens/a/confirm_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/background.dart';
import 'package:daily_tarot_poc_app_13/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.prevPage,
    required this.count,
    required this.child,
  });

  final String title;
  final Widget child;
  final Widget? prevPage;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Background1(
      child: Column(
        children: [
          SizedBox(height: 136),
          LogoWidget(title: title),

          child,

          Spacer(),

          if (prevPage != null)
            Row(
              spacing: 24,
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 95,
                  child: button(
                    "이전",
                    () => appController.back(context, prevPage!),
                  ),
                ),
                if (count == 5)
                  SizedBox(
                    width: 160,
                    child: button("잘 모르겠어요", () {
                      appController.time = null;
                      appController.go(context, ConfirmScreen());
                    }, isBack: false),
                  ),
              ],
            ),

          SizedBox(height: 48),

          if (count != null)
            Row(
              children: List.generate(
                5,
                (index) => Flexible(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: index < count! ? Colors.white : Colors.white54,
                      borderRadius: .circular(index < count! ? 8 : 0),
                    ),
                    margin: .only(left: index < count! ? 1 : 0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

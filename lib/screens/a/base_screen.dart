import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/a/confirm_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    required this.prevPage,
    required this.count,
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
                  child: button2("이전", () {
                    appController.back(context, prevPage!);
                  }),
                ),

                if (count == 5)
                  SizedBox(
                    width: 180,
                    child: button2("잘 모르겠어요", () {
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
                      borderRadius: .circular(index < count! ? 8 : 0),
                      color: index < count! ? Colors.white : Colors.white54,
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

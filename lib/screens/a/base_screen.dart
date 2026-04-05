import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/screens/a/confirm_screen.dart';
import 'package:daily_tarot_poc_app_14/widgets/background.dart';
import 'package:daily_tarot_poc_app_14/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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
          SizedBox(height: 130),

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

                if (count == 5)
                  SizedBox(
                    width: 170,
                    child: button2("잘 모르겠어요", () {
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
                    margin: .only(left: index < count! ? 1 : 0),
                    decoration: BoxDecoration(
                      color: index < count! ? Colors.white : Colors.white54,
                      borderRadius: .circular(index < count! ? 8 : 0),
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

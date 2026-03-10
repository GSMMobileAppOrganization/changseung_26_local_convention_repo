import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/widgets/background.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

class BaseInputPage extends StatelessWidget {
  const BaseInputPage({
    super.key,
    required this.title,
    required this.count,
    required this.prevPage,
    required this.child,
    this.expandButton,
  });

  final Widget child;
  final String title;
  final int count;
  final Widget prevPage;
  final Widget? expandButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          children: [
            SizedBox(height: 120),

            LogoWidget(title: title),
            Expanded(child: child),

            Row(
              mainAxisAlignment: .center,
              spacing: 12,
              children: [
                Button2(
                  tap: () => appController.moveReplace(context, prevPage),
                  text: "이전",
                  reverse: true,
                ),
                if (expandButton != null) ...{expandButton!},
              ],
            ),

            SizedBox(height: 48),

            PageIndicator(count: count),
          ],
        ),
      ),
    );
  }
}
